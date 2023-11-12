//
//  Category.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/11/23.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Category {
    var name: String = ""
    var symbol: String = ""
    var color: CodableColor = CodableColor.init(r: 20.0, g: 20.0, b: 20.0, a: 1.0)
    @Relationship(deleteRule: .cascade, inverse: \Transaction.category)
    var transactions: [Transaction]?

    init(name: String = "", symbol: String = "", color: CodableColor = .init(r: 20.0, g: 20.0, b: 20.0, a: 1.0), transactions: [Transaction]? = nil) {
        self.name = name
        self.symbol = symbol
        self.color = color
    }
}
