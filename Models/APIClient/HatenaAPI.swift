//
//  HatenaAPI.swift
//  Models
//
//  Created by 田辺信之 on 2018/12/07.
//  Copyright © 2018年 田辺信之. All rights reserved.
//

import Foundation
import RealmSwift

public struct EntryStars: Codable, APIClient {
    public var entries: [Entry]
    public struct Entry: Codable {
        public var stars: [Star]
        public struct Star: Codable {
            var quote: String?
            var name: String
        }
        public var canComment: Int
        public var uri: String

        private enum CodingKeys: String, CodingKey {
            case stars = "stars"
            case canComment = "can_comment"
            case uri = "uri"
        }
    }
    public var canComment: Int

    private enum CodingKeys: String, CodingKey {
        case entries = "entries"
        case canComment = "can_comment"
    }

    public static func from(response: Response) -> Either<TransformError, EntryStars> {
        switch response.statusCode {
        case .ok:
            do {
                let jsonDecoder = JSONDecoder()
                let result = try jsonDecoder.decode(EntryStars.self, from: response.payload)
                return .right(result)
            } catch {
                return .left(.malformedDeta(debugInfo: "\(error)"))
            }
        default:
            return .left(.unexpectedStatusCode(debugInfo: "\(response.statusCode)"))
        }
    }

    public static func fetch(
        urlString: String,
        _ block: @escaping (Either<Either<ConnectionError, TransformError>, EntryStars>) -> Void
    ) {
        let string = "http://s.hatena.com/entry.json?uri=\(urlString)"
        guard let url = URL(string: string) else {
            block(.left(.left(.malformedURL(debugInfo: "\(urlString)"))))
            return
        }
        let input: Input = (
            url: url,
            queries: [],
            headers: ["Content-Type": "application/json"],
            methodAndPayload: .get
        )

        WebAPI.call(with: input) { output in
            switch output {
            case let .noResponse(connectionError):
                block(.left(.left(connectionError)))
            case let .hasResponse(response):
                let errorOrData = EntryStars.from(response: response)
                switch errorOrData {
                case let .left(transformeError):
                    block(.left(.right(transformeError)))
                case let .right(result):
                    block(.right(result))
                }
            }
        }
    }
}

extension String {
    func containUser(strings: Results<BlockUser>) -> Bool {
        for string in strings {
            if self.contains(string.userName) { return true }
        }
        return false
    }
}

public struct HatenaEntry: Codable, APIClient {
    // 記事の基本的な情報
    public var entryUrl: String
    public var screenshot: String
    public var count: Int
    public var related: [Related]
    public var bookmarks: [Bookmarks]
    public var url: String
    public var title: String
    public var eid: String

    // 関連記事
    public struct Related: Codable {
        private var entryUrl: String
        public var count: Int
        public var title: String
        public var eid: String

        private enum CodingKeys: String, CodingKey {
            case entryUrl = "entry_url"
            case count = "count"
            case title = "title"
            case eid = "eid"
        }
    }

    public mutating func thinOutBlockedUser() {
        let realm = try? Realm()
        guard let list = realm?.objects(BlockUser.self) else { return }
        bookmarks = bookmarks.filter { !$0.user.containUser(strings: list) }
    }
    // ブクマ情報
    public struct Bookmarks: Codable {
        public var timestamp: String
        public var tags: [String]
        public var comment: String
        public var user: String
    }

    private enum CodingKeys: String, CodingKey {
        case entryUrl = "entry_url"
        case screenshot = "screenshot"
        case count = "count"
        case related = "related"
        case bookmarks = "bookmarks"
        case url =  "url"
        case title = "title"
        case eid = "eid"
    }

    public static func from(response: Response) -> Either<TransformError, HatenaEntry> {
        switch response.statusCode {
        case .ok:
            do {
                let jsonDecoder = JSONDecoder()
                let result = try jsonDecoder.decode(HatenaEntry.self, from: response.payload)
                return .right(result)
            } catch {
                return .left(.malformedDeta(debugInfo: "\(error)"))
            }
        default:
            return .left(.unexpectedStatusCode(debugInfo: "\(response.statusCode)"))
        }
    }

    public static func fetch(
        urlString: String,
        _ block: @escaping (Either<Either<ConnectionError, TransformError>, HatenaEntry>) -> Void
    ) {
        let urlString = "http://b.hatena.ne.jp/entry/json/?url=\(urlString)"
        guard let url = URL(string: urlString) else {
            block(.left(.left(.malformedURL(debugInfo: "\(urlString)"))))
            return
        }
        let input: Input = (
            url: url,
            queries: [],
            headers: ["Content-Type": "application/json"],
            methodAndPayload: .get
        )

        WebAPI.call(with: input) { output in
            switch output {
            case let .noResponse(connectionError):
                block(.left(.left(connectionError)))
            case let .hasResponse(response):
                let errorOrData = HatenaEntry.from(response: response)
                switch errorOrData {
                case let .left(transformError):
                    block(.left(.right(transformError)))
                case let .right(result):
                    block(.right(result))
                }
            }
        }
    }

    public mutating func decimateNoTextComment() {
        self.bookmarks = bookmarks.filter {
            $0.comment != ""
        }
    }

}

public struct EntryStar: Codable {
    public var entries: Entries

    public struct Entries: Codable {
        //        var stars: [String: String
    }
}

public struct PostTokenStatus: Codable, APIClient {
    var data: Status

    struct Status: Codable {
        var status: Bool
        var message: String
    }

    /// レスポンスから PostTokenStatus オブジェクトへ変換する関数。
    public static func from(response: Response) -> Either<TransformError, PostTokenStatus> {
        switch response.statusCode {
        // HTTP ステータスが OK だったら、ペイロードの中身を確認する。
        case .ok:
            do {
                // User API は JSON 形式の文字列を返すはずので Data を JSON として
                // 解釈してみる。
                let jsonDecoder = JSONDecoder()
                let result = try jsonDecoder.decode(PostTokenStatus.self, from: response.payload)

                // もし、内容を JSON として解釈できたなら、
                // その文字列から PostTokenStatus を作って返す（エラーではない型は右なので .right を使う）
                return .right(result)
            } catch {
                // もし、Data が JSON 文字列でなければ、何か間違ったデータを受信してしまったのかもしれない。
                // この場合は、malformedData エラーを返す（エラーの型は左なので .left を使う）。
                return .left(.malformedDeta(debugInfo: "\(error)"))
            }

            // もし、HTTP ステータスコードが OK 以外であれば、エラーとして扱う。
            // たとえば、Wannagoの API を呼び出しすぎたときは 200 OK ではなく 403 Forbidden が
        // 返るのでこちらにくる。
        default:
            // エラーの内容がわかりやすいようにステータスコードを入れて返す。
            return .left(.unexpectedStatusCode(debugInfo: "\(response.statusCode)"))
        }
    }

    static func fetch(
        params: [String: Any],
        _ block: @escaping (Either<Either<ConnectionError, TransformError>, PostTokenStatus>) -> Void
    ) {
        guard let domainString = Bundle.main.object(forInfoDictionaryKey: "GetDomainURL") as? String else { return }
        let urlString = "\(domainString)/api/v1/user_push_notification_tokens/create"
        guard let url = URL(string: urlString) else {
            block(.left(.left(.malformedURL(debugInfo: "\(urlString))"))))
            return
        }
        guard let data = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted) else { return }
        let input: Input = (
            url: url,
            queries: [],
            headers: ["Content-Type": "application/json"],
            methodAndPayload: .post(payload: data)
        )

        // 指定したパラメータでAPI呼び出し
        WebAPI.call(with: input) { output in
            switch output {
            case let .noResponse(connectionError):
                block(.left(.left(connectionError)))
            case let .hasResponse(response):
                // 変換
                let errorOrStatus = PostTokenStatus.from(response: response)
                switch errorOrStatus {
                case let .left(transformError):
                    // 変換エラー
                    block(.left(.right(transformError)))
                case let .right(result):
                    block(.right(result))
                }

            }
        }
    }

}

struct SpotDetail: Codable, APIClient {
    static func from(response: Response) -> Either<TransformError, SpotDetail> {
        switch response.statusCode {
        case .ok:
            do {
                let jsonDecoder = JSONDecoder()
                let result = try jsonDecoder.decode(SpotDetail.self, from: response.payload)
                return .right(result)
            } catch {
                return .left(.malformedDeta(debugInfo: "\(error)"))
            }
        default:
            return .left(.unexpectedStatusCode(debugInfo: "\(response.statusCode)"))
        }
    }

    static func fetch(
        spotId: String,
        ownId: String,
        _ block: @escaping (Either<Either<ConnectionError, TransformError>, SpotDetail>) -> Void
    ) {
        guard let domainString = Bundle.main.object(forInfoDictionaryKey: "GetDomainURL") as? String else { return }
        let urlString = "\(domainString)/api/v1/spots/\(spotId)?own_id=\(ownId)"
        guard let url = URL(string: urlString) else {
            block(.left(.left(.malformedURL(debugInfo: "\(urlString))"))))
            return
        }
        let input: Input = (
            url: url,
            queries: [],
            headers: ["Content-Type": "application/json"],
            methodAndPayload: .get
        )

        WebAPI.call(with: input) { output in
            switch output {
            case let .noResponse(connectionError):
                block(.left(.left(connectionError)))
            case let.hasResponse(response):
                let errorOrData = SpotDetail.from(response: response)
                switch errorOrData {
                case let .left(transformeError):
                    block(.left(.right(transformeError)))
                case let .right(result):
                    block(.right(result))
                }
            }

        }
    }

    var data: SpotInfo

    struct SpotInfo: Codable {
        var id: Int
        var spotName: String
        var lat: Double
        var lng: Double
        var createdAt: String
        var address: String?
        var postCode: String?
        var url: String?
        var digest: [Digest]?
        var comments: [SpotComment]?
        var closeSpots: [CloseSpot]?
        var hasMoreImages: Bool
        var sum: Int
        var commentSum: Int
        var hasMoreComments: Bool
        private enum CodingKeys: String, CodingKey {
            case id = "id"
            case spotName = "spot_name"
            case lat = "lat"
            case lng = "lng"
            case createdAt = "created_at"
            case address = "address"
            case postCode = "post_code"
            case url = "url"
            case digest = "digest"
            case comments = "comments"
            case closeSpots = "close_spots"
            case hasMoreImages = "has_more_images"
            case sum = "sum"
            case commentSum = "comment_sum"
            case hasMoreComments = "has_more_comments"
        }
    }

    struct Digest: Codable {
        var id: Int
        var image: String
        var favCount: Int
        var userId: Int
        var username: String
        var nickname: String
        var userIcon: String

        private enum CodingKeys: String, CodingKey {
            case id = "id"
            case image = "image"
            case favCount = "fav_count"
            case userId = "user_id"
            case username = "username"
            case nickname = "nickname"
            case userIcon = "user_icon"
        }
    }

    struct SpotComment: Codable {
        var userId: Int
        var comment: String
        var userIcon: String
        var userNickname: String
        var userUsername: String
        var createdAt: String

        private enum CodingKeys: String, CodingKey {
            case userId = "user_id"
            case comment = "comment"
            case userIcon = "user_icon"
            case userNickname = "user_nickname"
            case userUsername = "user_username"
            case createdAt = "created_at"
        }
    }

    struct CloseSpot: Codable {
        var id: Int
        var spotName: String
        var photos: [Photos]

        private enum CodingKeys: String, CodingKey {
            case id = "id"
            case spotName = "spot_name"
            case photos = "photos"
        }

        struct Photos: Codable {
            var photoId: String
            var image: String

            private enum CodingKeys: String, CodingKey {
                case photoId = "photo_id"
                case image = "image"
            }
        }
    }
}
