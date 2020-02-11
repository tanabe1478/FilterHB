//
//  FiltersDataSource.swift
//  FileterHB
//
//  Created by 田辺信之 on 2018/12/12.
//  Copyright © 2018年 田辺信之. All rights reserved.
//

import Foundation
import UIKit
import Models
import RealmSwift

class FiltersDataSource: NSObject, UITableViewDataSource, FilteringWordCellDataSource {
    // Realmを使ったデータベースに関するプロパティ・メソッド
    var realm: Realm!
    var wordList: Results<FilterWord>!
    var token: NotificationToken!

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilteringWordCell.nibName, for: indexPath) as? FilteringWordCell else { fatalError() }
        cell.index = indexPath.row
        cell.dataSource = self
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            FilterWord.deleteWord(at: indexPath.row, realm: realm, list: wordList)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
