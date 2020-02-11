//
//  InstantiableFromNib.swift
//  FileterHB
//
//  Created by 田辺信之 on 2018/11/10.
//  Copyright © 2018年 田辺信之. All rights reserved.
//
import Foundation
import UIKit
protocol InstantiatableFromNib {
    static var nibName: String { get }
    //static func instantiateFromNib() -> Self
}

extension InstantiatableFromNib where Self: UIView {
    static var nibName: String {
        return String(describing: Self.self)
    }

    static func instantiateFromNib() -> Self {
        let nib = UINib(nibName: nibName, bundle: nil)
        guard let selfIns = nib.instantiate(withOwner: nil, options: nil).first as? Self else { fatalError() }
        return selfIns
    }
}
