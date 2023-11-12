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
    var color: CodableColor = CodableColor.init(r: 20, g: 20, b: 20, a: 1)
    @Relationship(deleteRule: .cascade, inverse: \Transaction.category)
    var transactions: [Transaction]?
    
    init(name: String = "", symbol: String = "", color: CodableColor = .init(r: 20, g: 20, b: 20, a: 1), transactions: [Transaction] = []) {
        self.name = name
        self.symbol = symbol
        self.color = color
    }
}
