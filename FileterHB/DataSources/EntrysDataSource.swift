//
//  HomeVCDataSource.swift
//  FileterHB
//
//  Created by 田辺信之 on 2018/11/10.
//  Copyright © 2018年 田辺信之. All rights reserved.
//

import Foundation
import UIKit
import Models
import RealmSwift

extension String {
    func containWords(strings: Results<FilterWord>) -> Bool {
        for string in strings {
            if self.contains(string.word) { return true }
        }
        return false
    }
}

class EntrysDataSource: NSObject, UITableViewDataSource, EntryCellDataSource {
    var urlList: UrlList?
    var rssItems: [RSSItem]?

    func filtering(rssItems: [RSSItem], block: @escaping ([RSSItem]) -> Void) {
        guard let realm = try? Realm() else { fatalError() }
        let list = realm.objects(FilterWord.self)
        block(rssItems.filter { !$0.title.containWords(strings: list) })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rssItems = rssItems else {
            return 0
        }
        return rssItems.count
    }
    func registerCell(tableView: UITableView) {
        tableView.register(UINib(nibName: EntryCell.nibName, bundle: nil), forCellReuseIdentifier: EntryCell.nibName)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EntryCell.nibName) as? EntryCell else {
            fatalError()
        }
        guard rssItems != nil else { return UITableViewCell() }
        cell.index = indexPath.row
        cell.dataSource = self
        return cell
    }

    func getUrl(index: Int) -> String? {
        guard let rssItems = rssItems else {
            return nil
        }
        guard !(rssItems.isEmpty) else {
            return nil
        }
        return rssItems[index].url
    }

    func getRSS(tableView: UITableView, urlList: UrlList) {
        let feedParser = FeedParser()
        feedParser.parseFeed(url: urlList) { (rssItems) in
            self.filtering(rssItems: rssItems) {list in
                self.rssItems = list
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            }
        }
    }
}
