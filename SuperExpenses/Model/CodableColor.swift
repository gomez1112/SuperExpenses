//
//  CodableColor.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/11/23.
//

import Foundation

struct CodableColor: Codable, Hashable {
    var r: CGFloat = 10
    var g: CGFloat = 10
    var b: CGFloat = 10
    var a: CGFloat = 10
    
    init(r: CGFloat = 10, g: CGFloat = 10, b: CGFloat = 10, a: CGFloat = 10) {
        self.r = r
        self.g = g
        self.b = b
        self.a = a
    }
}
