//
//  ShareEntryActivity.swift
//  FileterHB
//
//  Created by 田辺信之 on 2018/12/20.
//  Copyright © 2018 田辺信之. All rights reserved.
//

import UIKit
import Foundation

class ShareEntryActivity: UIActivity {
    public var URL: URL?
    // title
    override var activityTitle: String? {
        return "open in Safari"
    }

    // image
    override public var activityImage: UIImage? {
        return UIImage(named: "safari")
    }

    /*
     // 動作させるかどうか
     // ex.URLを開けるならtrue、開けないならfalse
     */
    override public func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        guard activityItems[1] as? URL != nil else { return false }
        return true
    }

    // 動く直前にしたい動作
    override public func prepare(withActivityItems activityItems: [Any]) {
        guard let url = activityItems[1] as? URL else { return }
        self.URL = url
    }

    // 選択されたときにしたい処理
    override public func perform() {
        guard let URL = URL else {
            self.activityDidFinish(false)
            return
        }
        UIApplication.shared.open(URL)
        self.activityDidFinish(true)
    }
}
