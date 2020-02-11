//
//  String+Extensions.swift
//  Models
//
//  Created by 田辺信之 on 2018/11/06.
//  Copyright © 2018年 田辺信之. All rights reserved.
//

import Foundation
extension String {
    func trimmingWhitespacesAndNewline() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
