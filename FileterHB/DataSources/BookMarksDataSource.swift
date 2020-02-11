//
//  BookMarksDataSource.swift
//  Models
//
//  Created by 田辺信之 on 2018/12/08.
//  Copyright © 2018年 田辺信之. All rights reserved.
//

import Foundation
import UIKit
import Models
import SDWebImage
import RealmSwift

class BookmarksDataSource: NSObject, UITableViewDataSource, BookmarkCellDataSource {
    var hatenaEntry: HatenaEntry?
    var starCountArray: [Int] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let hatenaEntry = hatenaEntry else { return 0 }
        return hatenaEntry.bookmarks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard hatenaEntry != nil else { return UITableViewCell() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookmarkCell.nibName, for: indexPath) as? BookmarkCell else {
            fatalError("The cell cannot initialize")
        }
        cell.index = indexPath.row
        cell.dataSource = self
        return cell
    }

    func getUserId(indexPath: IndexPath) -> String {
        return hatenaEntry!.bookmarks[indexPath.row].user
    }
}
