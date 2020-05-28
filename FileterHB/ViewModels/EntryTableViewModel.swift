//
//  EntryTableViewModel.swift
//  FileterHB
//
//  Created by tanabe.nobuyuki on 2020/02/11.
//  Copyright © 2020 田辺信之. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class EntryTableViewModel {
    let input: Input
    let output: Output

    init() {
        self.input = Input()
        self.output = Output()
        do {

        }
    }
}

extension EntryTableViewModel {
    // methodInvoked(_:)の返り値にbindする処理
    struct Input {
    }

    struct Output {

    }
}
