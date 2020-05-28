//
//  EntryModel.swift
//  Models
//
//  Created by tanabe.nobuyuki on 2020/02/11.
//  Copyright © 2020 田辺信之. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct ErrorMessage {
    let title: String
    let message: String
}

final class EntryModel {
    //    let errorMessage: Observable<ErrorMessage>
    let rssItems: Observable<[RSSItem]>

    private let _rssItems = BehaviorRelay<[RSSItem]>(value: [])

    init() {
        self.rssItems = _rssItems.asObservable()
    }
}
