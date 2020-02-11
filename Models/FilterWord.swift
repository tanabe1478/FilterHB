//
//  FilterWord.swift
//  Models
//
//  Created by 田辺信之 on 2018/12/20.
//  Copyright © 2018 田辺信之. All rights reserved.
//

import Foundation
import RealmSwift

public class FilterWord: Object {
    @objc dynamic public var word: String = ""
    public static func addWord(word: String, realm: Realm) {
        do {
            try realm.write {
                realm.add(FilterWord(value: ["word": word]))
            }
        } catch {
            fatalError("フィルターの追加に失敗")
        }
    }

    public static func deleteWord(at index: Int, realm: Realm, list: Results<FilterWord>) {
        do {
            try realm.write {
                realm.delete(list[index])
            }
        } catch {
            fatalError("フィルターの削除に失敗")
        }
    }
}
