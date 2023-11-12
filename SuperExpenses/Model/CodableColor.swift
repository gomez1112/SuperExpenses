//
//  CodableColor.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/11/23.
//

import Foundation

struct CodableColor: Codable, Hashable {
    var r: CGFloat = 10.0
    var g: CGFloat = 10.0
    var b: CGFloat = 10.0
    var a: CGFloat = 10.0
    
    init(r: CGFloat = 10.0, g: CGFloat = 10.0, b: CGFloat = 10.0, a: CGFloat = 10.0) {
        self.r = r
        self.g = g
        self.b = b
        self.a = a
    }
}
