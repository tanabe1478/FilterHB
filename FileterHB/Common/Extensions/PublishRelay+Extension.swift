//
//  PublishRelay+Extension.swift
//  FileterHB
//
//  Created by tanabe.nobuyuki on 2020/02/11.
//  Copyright © 2020 田辺信之. All rights reserved.
//

import RxCocoa
import RxSwift

public extension PublishRelay {
    func asObserver() -> AnyObserver<Element> {
        return AnyObserver { $0.element.map(self.accept) }
    }
}
