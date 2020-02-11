//
//  BlockUser.swift
//  Models
//
//  Created by 田辺信之 on 2019/02/18.
//  Copyright © 2019 田辺信之. All rights reserved.
//

import Foundation
import RealmSwift

public class BlockUser: Object {
    @objc dynamic public var userName: String = ""
    public static func addUser(userName: String, realm: Realm) {
        try? realm.write {
            realm.add(BlockUser(value: ["userName": userName]))
        }
    }

    public static func deleteUser(at index: Int, realm: Realm, list: Results<BlockUser>) {
        try? realm.write {
            realm.delete(list[index])
        }
    }

    public static func deleteUser(userName: String, realm: Realm, list: Results<BlockUser>) {
        try? realm.write {
            let strings = list.map { $0.userName }
            if let index = strings.firstIndex(of: userName) {
                realm.delete(list[index])
            }
        }
    }

    public static func hasUser(userName: String, list: Results<BlockUser>, completion: @escaping (Bool) -> Void) {
        let strings = list.map { $0.userName }
        completion(strings.contains(userName))
    }
}
