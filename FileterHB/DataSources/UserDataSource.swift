//
//  UserDataSource.swift
//  FileterHB
//
//  Created by 田辺信之 on 2019/02/18.
//  Copyright © 2019 田辺信之. All rights reserved.
//

import Foundation
import Models
import RealmSwift

class UserDataSource: NSObject, UITableViewDataSource, UserBookmarkCellDataSource {
    var rssItems: [RSSItem]?
    var urlString: String?
    var userId: String!
    var iconUrl: URL!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rssItems = rssItems else { return 0 }
        return rssItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserBookmarkCell.nibName, for: indexPath) as? UserBookmarkCell else { fatalError() }
        cell.index = indexPath.row
        cell.dataSource = self
        return cell
    }

    func getRSS(tableView: UITableView, urlString: String) {
        let feedParser = FeedParser()
        feedParser.parseFeed(urlString: urlString) { (rssItems) in
            self.rssItems = rssItems
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
    }
}
