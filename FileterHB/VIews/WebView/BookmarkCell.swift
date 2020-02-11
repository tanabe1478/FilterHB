//
//  Bookmark.swift
//  FileterHB
//
//  Created by 田辺信之 on 2018/12/08.
//  Copyright © 2018年 田辺信之. All rights reserved.
//

import UIKit
import Models

class BookmarkCell: UITableViewCell, InstantiatableFromNib {
    @IBOutlet weak private var iconImageView: UIImageView!
    @IBOutlet weak private var createdAtLabel: UILabel!
    @IBOutlet weak private var commentLabel: UILabel!
    @IBOutlet weak private var starImageView: UIImageView!
    @IBOutlet weak private var idLabel: UILabel!
    var eid: String!
    var index: Int!
    weak var dataSource: BookmarkCellDataSource? {
        didSet { setLayout() }
    }
    var timestamp: String!
    var userId: String!
    var starCount: Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setLayout() {
        guard let dataSource = dataSource, let hatenaEntry = dataSource.hatenaEntry, let bookmark = dataSource.hatenaEntry?.bookmarks[index] else { return }
        DispatchQueue.main.async {
            self.commentLabel.text = bookmark.comment
            self.createdAtLabel.text = bookmark.timestamp
            self.idLabel.text = bookmark.user
            self.iconImageView.sd_setImage(with: dataSource.getIconUrl(index: self.index))
            self.eid = hatenaEntry.eid
            self.timestamp = bookmark.timestamp
            self.userId = bookmark.user
            guard let string = "http://b.hatena.ne.jp/\(self.userId!)/\(self.getFormatedDateString())#bookmark-\(self.eid!)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { fatalError() }
            let url = "http://s.st-hatena.com/entry.count.image?uri=\(string)&q=1"
            self.starImageView.sd_setImage(with: URL(string: url))
        }

    }

    func getFormatedDateString() -> String {
        let dateFormater = DateFormatter()
        dateFormater.locale = Locale(identifier: "ja_JP")
        dateFormater.dateFormat = "yyyy/MM/dd HH:mm"
        let date = dateFormater.date(from: self.timestamp)
        // 変換して返す
        let seconddateFormater = DateFormatter()
        seconddateFormater.locale = Locale(identifier: "ja_JP")
        seconddateFormater.dateFormat = "yyyyMMdd"
        let string = seconddateFormater.string(from: date!)
        return string
    }

    override func prepareForReuse() {

    }
}

protocol BookmarkCellDataSource: AnyObject {
    var hatenaEntry: HatenaEntry? { get set }
    func getIconUrl(index: Int) -> URL?
}

extension BookmarkCellDataSource {
    func getIconUrl(index: Int) -> URL? {
        guard let hatenaEntry = hatenaEntry else { return nil }
        return URL(string: "http://cdn1.www.st-hatena.com/users/\(hatenaEntry.bookmarks[index].user.prefix(2))/\(hatenaEntry.bookmarks[index].user)/profile.gif")
    }
}
