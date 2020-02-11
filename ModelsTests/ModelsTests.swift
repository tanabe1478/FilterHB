//
//  ModelsTests.swift
//  ModelsTests
//
//  Created by 田辺信之 on 2018/11/06.
//  Copyright © 2018年 田辺信之. All rights reserved.
//

import XCTest
@testable import Models

class ModelsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testDecodeHatenaEntryJson() {
        let data = """
{
  "entry_url": "http://b.hatena.ne.jp/entry/s/syncer.jp/hatebu-api-matome",
  "screenshot": "http://b.hatena.ne.jp/images/v4/public/common/noimage.png",
  "count": 126,
  "related": [
    {
      "entry_url": "http://b.hatena.ne.jp/entry/d.hatena.ne.jp/mame-tanuki/20090526/hatebu_plus",
      "count": 46,
      "title": "有料オプション「はてなブックマークプラス」が微妙すぎる件 - そっと××",
      "eid": "13668578"
    },
    {
      "title": "Web系の記事でホッテントリする為の8つの条件 | パシのSEOブログ",
      "eid": "14790198",
      "entry_url": "http://b.hatena.ne.jp/entry/www.jweb-seo.com/blog/wordpress/2009/07/21/693",
      "count": 272
    },
    {
      "count": 373,
      "entry_url": "http://b.hatena.ne.jp/entry/stocker.jp/diary/hatena_bookmark_no1/",
      "eid": "27681107",
      "title": "はてブ1位になると、何が起きるのかまとめてみた | Stocker.jp / diary"
    },
    {
      "eid": "293328034",
      "title": "相互ブクマはてなブロガーリスト",
      "entry_url": "http://b.hatena.ne.jp/entry/hatebu.ta2o.net/gojo/",
      "count": 753
    },
    {
      "entry_url": "http://b.hatena.ne.jp/entry/s/www.hobiwo.com/entry/hatenakotowaza",
      "count": 51,
      "eid": "4653188410233038017",
      "title": "はてなブロガー必見！#ブログ運営にまったく役立たないことわざ 20選 - ホビヲログ"
    }
  ],
  "bookmarks": [
    {
      "timestamp": "2018/11/23 02:04",
      "tags": [
        "あとで読む"
      ],
      "user": "beatdjam",
      "comment": ""
    },
    {
      "timestamp": "2018/10/26 11:41",
      "comment": "",
      "tags": [
        "*JS",
        "はてブAPI"
      ],
      "user": "pkdick"
    },
    {
      "comment": "",
      "user": "PACIFIST",
      "tags": [
        "API"
      ],
      "timestamp": "2018/10/11 06:27"
    },
    {
      "user": "rutei",
      "tags": [],
      "comment": "",
      "timestamp": "2018/09/03 14:02"
    },
    {
      "comment": "",
      "tags": [],
      "user": "zetta1985",
      "timestamp": "2018/08/29 23:58"
    },
    {
      "timestamp": "2018/07/11 16:09",
      "user": "cowbee",
      "tags": [],
      "comment": ""
    },
    {
      "user": "woodnotexx",
      "tags": [],
      "comment": "",
      "timestamp": "2018/05/01 19:22"
    },
    {
      "comment": "",
      "user": "take-it",
      "tags": [
        "はてなブックマーク",
        "api",
        "あとで読む"
      ],
      "timestamp": "2018/04/24 02:46"
    },
    {
      "timestamp": "2018/02/25 19:12",
      "user": "menheraneet",
      "tags": [
        "あとで読む"
      ],
      "comment": ""
    },
    {
      "timestamp": "2017/12/29 03:15",
      "user": "ymm1x",
      "tags": [
        "api"
      ],
      "comment": ""
    },
    {
      "timestamp": "2017/12/28 11:31",
      "comment": "",
      "tags": [],
      "user": "ghfgfg"
    },
    {
      "comment": "",
      "user": "ayb",
      "tags": [],
      "timestamp": "2017/12/27 22:35"
    },
    {
      "comment": "APIって最強だな！",
      "user": "takashi94601",
      "tags": [
        "webサービス",
        "Web",
        "API",
        "あとで読む",
        "はてなブックマーク",
        "hatena",
        "はてブ",
        "はてな",
        "PHP"
      ],
      "timestamp": "2017/11/27 04:36"
    },
    {
      "timestamp": "2017/10/20 21:40",
      "comment": "",
      "tags": [
        "API"
      ],
      "user": "muutarosan"
    },
    {
      "timestamp": "2017/09/29 16:13",
      "comment": "",
      "user": "shingo_jp",
      "tags": [
        "ウェブサービス",
        "サービス",
        "API",
        "PHP",
        "はてな"
      ]
    },
    {
      "timestamp": "2017/09/28 16:56",
      "comment": "",
      "user": "cka-lek",
      "tags": [
        "API",
        "はてブ"
      ]
    },
    {
      "comment": "",
      "user": "wushi",
      "tags": [
        "あとで読む"
      ],
      "timestamp": "2017/09/05 02:35"
    },
    {
      "comment": "",
      "user": "peketamin",
      "tags": [],
      "timestamp": "2017/09/04 05:33"
    },
    {
      "timestamp": "2017/08/29 14:17",
      "tags": [],
      "user": "mamimp",
      "comment": ""
    },
    {
      "comment": "",
      "tags": [],
      "user": "swiminclouds",
      "timestamp": "2017/07/03 12:19"
    },
    {
      "user": "kenjiro_n",
      "tags": [
        "webAPI",
        "hatena",
        "sbm",
        "PHP"
      ],
      "comment": "",
      "timestamp": "2017/06/28 00:38"
    },
    {
      "timestamp": "2017/04/21 12:09",
      "comment": "はてブAPI使うときの参考にしたい",
      "tags": [],
      "user": "hata-navi"
    },
    {
      "timestamp": "2017/04/01 02:42",
      "comment": "",
      "user": "syofuso",
      "tags": [
        "はてなブックマーク",
        "はてブ",
        "API"
      ]
    },
    {
      "timestamp": "2017/03/20 23:06",
      "user": "fenrir-naru",
      "tags": [
        "サーバー管理"
      ],
      "comment": ""
    },
    {
      "comment": "",
      "user": "zyusou",
      "tags": [
        "webサービス",
        "web",
        "API"
      ],
      "timestamp": "2017/02/24 10:49"
    },
    {
      "timestamp": "2017/02/05 00:27",
      "user": "coachenigmatic",
      "tags": [
        "webサービス"
      ],
      "comment": ""
    },
    {
      "user": "yoshia_e",
      "tags": [
        "WEB／ブログ制作",
        "はてな",
        "API"
      ],
      "comment": "",
      "timestamp": "2017/01/28 12:04"
    },
    {
      "timestamp": "2017/01/18 01:28",
      "user": "nunpascals",
      "tags": [],
      "comment": ""
    },
    {
      "timestamp": "2017/01/10 01:46",
      "comment": "",
      "tags": [
        "他技術系"
      ],
      "user": "asahiufo"
    },
    {
      "comment": "",
      "user": "xKxAxKx",
      "tags": [
        "あとで読む"
      ],
      "timestamp": "2016/12/03 23:17"
    },
    {
      "comment": "",
      "user": "nasust",
      "tags": [],
      "timestamp": "2016/11/29 07:04"
    },
    {
      "tags": [],
      "user": "tanishiking24",
      "comment": "",
      "timestamp": "2016/11/24 16:37"
    },
    {
      "timestamp": "2016/11/20 17:52",
      "user": "ottonove",
      "tags": [
        "あとで読む"
      ],
      "comment": ""
    },
    {
      "timestamp": "2016/11/16 17:11",
      "comment": "",
      "user": "tatsu-n",
      "tags": []
    },
    {
      "comment": "",
      "tags": [
        "はてなブックマーク",
        "webサービス",
        "はてブ",
        "API"
      ],
      "user": "tiki0108",
      "timestamp": "2016/11/09 17:30"
    },
    {
      "tags": [
        "API",
        "webサービス"
      ],
      "user": "kohak_d",
      "comment": "",
      "timestamp": "2016/10/24 17:38"
    },
    {
      "timestamp": "2016/10/04 12:56",
      "user": "konisimple",
      "tags": [],
      "comment": ""
    },
    {
      "comment": "書籍レベル。",
      "user": "yto",
      "tags": [],
      "timestamp": "2016/09/26 15:07"
    },
    {
      "comment": "",
      "user": "Dhio",
      "tags": [],
      "timestamp": "2016/09/14 05:23"
    },
    {
      "tags": [
        "はてなブックマーク",
        "API"
      ],
      "user": "halloween_jack",
      "comment": "",
      "timestamp": "2016/07/26 18:46"
    },
    {
      "tags": [],
      "user": "hiiron",
      "comment": "",
      "timestamp": "2016/07/05 17:13"
    },
    {
      "timestamp": "2016/07/05 11:36",
      "comment": "本気のはてブ活用法",
      "user": "yomikodesign",
      "tags": []
    },
    {
      "timestamp": "2016/06/18 23:01",
      "user": "razokulover",
      "tags": [],
      "comment": ""
    },
    {
      "timestamp": "2016/05/31 00:50",
      "comment": "",
      "user": "yaskohik",
      "tags": []
    },
    {
      "comment": "",
      "user": "swfz",
      "tags": [],
      "timestamp": "2016/05/30 21:55"
    },
    {
      "tags": [
        "はてブ",
        "WEBサービス",
        "api"
      ],
      "user": "Bi-213",
      "comment": "",
      "timestamp": "2016/05/19 20:55"
    },
    {
      "timestamp": "2016/05/02 23:34",
      "comment": "",
      "tags": [
        "API",
        "サービス",
        "はてな",
        "webサービス"
      ],
      "user": "z_dogma"
    },
    {
      "comment": "",
      "tags": [],
      "user": "kenichirou1225",
      "timestamp": "2016/04/22 10:23"
    },
    {
      "timestamp": "2016/04/21 17:03",
      "tags": [],
      "user": "MoneyReport",
      "comment": "コレで何か作ってみよう！っと♪"
    },
    {
      "comment": "",
      "user": "merlion45",
      "tags": [],
      "timestamp": "2016/04/21 10:43"
    },
    {
      "comment": "",
      "user": "i000i0",
      "tags": [],
      "timestamp": "2016/04/12 19:34"
    },
    {
      "comment": "",
      "user": "akanehara",
      "tags": [],
      "timestamp": "2016/04/12 15:02"
    },
    {
      "tags": [
        "api",
        "はてブ",
        "php"
      ],
      "user": "yokkong",
      "comment": "",
      "timestamp": "2016/04/11 16:11"
    },
    {
      "comment": "",
      "user": "ponpoko04",
      "tags": [
        "はてなブックマーク",
        "はてブ",
        "API"
      ],
      "timestamp": "2016/04/03 22:49"
    },
    {
      "tags": [
        "はてなブックマーク",
        "webサービス"
      ],
      "user": "halohalolin",
      "comment": "はてなブックマークで、特定のキーワードで絞り込みたい場合は /search/text?q={キーワード}&mode=rss",
      "timestamp": "2016/04/02 19:35"
    },
    {
      "tags": [
        "API"
      ],
      "user": "shkamatiiju",
      "comment": "",
      "timestamp": "2016/03/15 13:18"
    },
    {
      "timestamp": "2016/03/05 22:53",
      "tags": [
        "あとで読む",
        "はてなブックマーク",
        "api",
        "サービス",
        "Web"
      ],
      "user": "takuya0411",
      "comment": ""
    },
    {
      "timestamp": "2016/03/03 08:43",
      "comment": "",
      "tags": [
        "はてブ"
      ],
      "user": "yatemmma"
    },
    {
      "comment": "",
      "tags": [
        "webサービス",
        "サービス",
        "はてブ",
        "はてなブックマーク"
      ],
      "user": "ico_aoba",
      "timestamp": "2016/02/24 16:48"
    },
    {
      "timestamp": "2016/02/18 17:58",
      "tags": [],
      "user": "michael26",
      "comment": ""
    },
    {
      "timestamp": "2016/01/27 12:35",
      "tags": [
        "hatena"
      ],
      "user": "nacika_inscatolare",
      "comment": ""
    },
    {
      "timestamp": "2016/01/18 13:52",
      "user": "cmd08",
      "tags": [
        "API",
        "はてな"
      ],
      "comment": ""
    },
    {
      "tags": [
        "はてな",
        "API",
        "webサービス",
        "hatena"
      ],
      "user": "tropicalsanta",
      "comment": "",
      "timestamp": "2016/01/02 15:40"
    },
    {
      "user": "moqada",
      "tags": [
        "hatena",
        "api"
      ],
      "comment": "",
      "timestamp": "2015/12/21 13:34"
    },
    {
      "timestamp": "2015/12/21 10:32",
      "user": "kyo_ago",
      "tags": [
        "api",
        "development",
        "hatena",
        "はてなブックマーク",
        "webサービス",
        "はてな",
        "Web",
        "tutorial",
        "php",
        "はてブ"
      ],
      "comment": ""
    },
    {
      "timestamp": "2015/12/21 07:17",
      "comment": "かwebサービス][はてな]",
      "tags": [
        "api"
      ],
      "user": "meganii"
    },
    {
      "user": "nabehiro",
      "tags": [
        "はてな",
        "はてなブックマーク",
        "API"
      ],
      "comment": "",
      "timestamp": "2015/12/14 19:07"
    },
    {
      "timestamp": "2015/12/13 07:09",
      "comment": "",
      "tags": [
        "hatena",
        "api",
        "reference",
        "tutorial",
        "development",
        "php"
      ],
      "user": "uchiuchiyama"
    },
    {
      "timestamp": "2015/12/13 05:01",
      "comment": "",
      "user": "ni66ling",
      "tags": [
        "はてなブックマーク",
        "API"
      ]
    },
    {
      "timestamp": "2015/12/08 13:28",
      "comment": "",
      "tags": [],
      "user": "sabacurry"
    },
    {
      "timestamp": "2015/12/07 12:28",
      "comment": "",
      "tags": [
        "api"
      ],
      "user": "mt_hodaka"
    },
    {
      "timestamp": "2015/12/07 00:18",
      "user": "id-mai-yamamoto",
      "tags": [],
      "comment": ""
    },
    {
      "user": "ryokujya",
      "tags": [
        "はてな",
        "API"
      ],
      "comment": "",
      "timestamp": "2015/11/26 13:36"
    },
    {
      "comment": "",
      "tags": [
        "Webサービス",
        "API",
        "はてなブックマーク",
        "サービス",
        "はてな",
        "hatena",
        "Web",
        "はてブ"
      ],
      "user": "cartman0",
      "timestamp": "2015/11/07 19:44"
    },
    {
      "timestamp": "2015/10/28 20:47",
      "user": "pppantsu",
      "tags": [],
      "comment": ""
    },
    {
      "timestamp": "2015/10/28 17:49",
      "tags": [
        "Webサービス",
        "API"
      ],
      "user": "amano41",
      "comment": ""
    },
    {
      "tags": [],
      "user": "aaafrog",
      "comment": "",
      "timestamp": "2015/10/27 08:20"
    },
    {
      "timestamp": "2015/10/21 09:44",
      "tags": [],
      "user": "yuhi_as",
      "comment": "Twitter OAuth連携できたから次はFacebook連携作ってあと何と連携しようかなーって思ってたけど、はてな連携もありかな"
    },
    {
      "timestamp": "2015/10/19 07:30",
      "user": "light940",
      "tags": [
        "はてなブックマーク",
        "API"
      ],
      "comment": ""
    },
    {
      "timestamp": "2015/10/19 06:16",
      "comment": "",
      "user": "mhkohei",
      "tags": []
    },
    {
      "comment": "",
      "user": "xiangze",
      "tags": [
        "webサービス"
      ],
      "timestamp": "2015/10/19 02:00"
    },
    {
      "timestamp": "2015/10/18 22:00",
      "tags": [],
      "user": "sucrose",
      "comment": ""
    },
    {
      "timestamp": "2015/10/17 11:58",
      "tags": [],
      "user": "orangeclover",
      "comment": ""
    },
    {
      "user": "rike422",
      "tags": [],
      "comment": "",
      "timestamp": "2015/10/13 13:14"
    },
    {
      "timestamp": "2015/10/12 07:29",
      "comment": "おお、すごい、丁寧",
      "user": "a-know",
      "tags": []
    },
    {
      "user": "localdisk",
      "tags": [
        "hatena"
      ],
      "comment": "",
      "timestamp": "2015/10/12 02:49"
    },
    {
      "user": "nabetama",
      "tags": [],
      "comment": "",
      "timestamp": "2015/10/11 22:45"
    },
    {
      "timestamp": "2015/10/11 20:43",
      "user": "jajkeqos",
      "tags": [],
      "comment": ""
    },
    {
      "timestamp": "2015/10/11 20:09",
      "comment": "",
      "user": "danda_debu",
      "tags": []
    },
    {
      "tags": [
        "はてなブックマーク",
        "API",
        "Web"
      ],
      "user": "mkt",
      "comment": "",
      "timestamp": "2015/10/11 19:49"
    },
    {
      "timestamp": "2015/10/11 19:02",
      "tags": [],
      "user": "kwms",
      "comment": ""
    },
    {
      "timestamp": "2015/10/11 16:25",
      "user": "tuki0918",
      "tags": [],
      "comment": ""
    },
    {
      "timestamp": "2015/10/11 16:19",
      "comment": "",
      "user": "Nyoho",
      "tags": [
        "hatena"
      ]
    },
    {
      "comment": "",
      "tags": [
        "hatena"
      ],
      "user": "gfx",
      "timestamp": "2015/10/11 14:55"
    },
    {
      "comment": "",
      "tags": [],
      "user": "SatoshiN21",
      "timestamp": "2015/10/05 13:39"
    },
    {
      "timestamp": "2015/10/02 12:19",
      "comment": "",
      "tags": [],
      "user": "jerico39"
    },
    {
      "comment": "",
      "tags": [],
      "user": "taka222",
      "timestamp": "2015/09/06 11:28"
    }
  ],
  "url": "https://syncer.jp/hatebu-api-matome",
  "title": "はてブAPIでwebサービスを作りたい全ての人に向けて書きました",
  "eid": "264997023"
}
""".data(using: .utf8)!
        if let result = try? JSONDecoder().decode(HatenaEntry.self, from: data) {
            print(result)
            fatalError()
        }
    }

    func testEntryAPiFetch() {
        let expectation = self.expectation(description: "HatenaAPI")
        HatenaEntry.fetch(urlString: "https://syncer.jp/hatebu-api-matome") { errorOrData in
            switch errorOrData {
            case let .left(error):
                XCTFail("\(error)")
            case var .right(status):
                XCTAssertEqual(status.entryUrl, "http://b.hatena.ne.jp/entry/s/syncer.jp/hatebu-api-matome")
                status.decimateNoTextComment()
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 10)

    }

    func testDecodeEntryStarJson() {
        let data = """
{
  "entries": [
    {
      "stars": [
        {
          "quote": "",
          "name": "afternoonteeee"
        },
        {
          "quote": "",
          "name": "n2s"
        }
      ],
      "can_comment": 0,
      "uri": "http://b.hatena.ne.jp/syncer/20150717#bookmark-228023"
    }
  ],
  "can_comment": 0
}
""".data(using: .utf8)!
        if let result = try? JSONDecoder().decode(EntryStars.self, from: data) {
            print(result)
            fatalError()
        }

    }

    func testFetchHatenaStarAPI() {
        let expectation = self.expectation(description: "HatenaStarAPI")
        guard let string = "http://b.hatena.ne.jp/syncer/20150717#bookmark-228023".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { fatalError() }
        EntryStars.fetch(urlString: string) { errorOrData in
            switch errorOrData {
            case let .left(error):
                XCTFail("\(error)")
            case let .right(data):
                XCTAssertEqual(data.entries.count, 1)
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 10)
    }
}
