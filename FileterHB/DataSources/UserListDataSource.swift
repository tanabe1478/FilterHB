//
//  UserNameData.swift
//  FileterHB
//
//  Created by 田辺信之 on 2019/02/18.
//  Copyright © 2019 田辺信之. All rights reserved.
//

import Foundation
import Models
import UIKit
import RealmSwift

class UserListDataSource: NSObject, UITableViewDataSource, BlockUserListCellDataSource {
    // Realmを使ったデータベースに関するプロパティ・メソッド
    var nameList: Results<BlockUser>!
    var token: NotificationToken!

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BlockUserListCell.nibName, for: indexPath) as? BlockUserListCell else { fatalError() }
        cell.index = indexPath.row
        cell.dataSource = self
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let realm = try? Realm() else { fatalError() }
            BlockUser.deleteUser(at: indexPath.row, realm: realm, list: nameList)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}
