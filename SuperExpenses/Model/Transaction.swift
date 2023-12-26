//
//  Transaction.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/11/23.
//

import Foundation
import SwiftData


@Model
final class Transaction: Identifiable {
    var name = ""
    var amount: Double = 0.0
    var kind: Kind = Kind.expense
    var classification: Classification = Classification.personal
    var category: Category?
    var date: Date = Date()
    var detail: String?
    
    init(name: String = "", amount: Double = 0.0, kind: Kind = .expense, classification: Classification = .personal, category: Category? = nil, date: Date = Date(), detail: String? = nil) {
        self.name = name
        self.amount = amount
        self.kind = kind
        self.classification = classification
        self.category = category
        self.date = date
        self.detail = detail
    }
    enum Kind: String, Identifiable, Codable, CaseIterable {
        case income
        case expense
        
        var id: Self { self }
    }
    
    enum Classification: String, Identifiable, Codable, CaseIterable {
        case personal
        case business
        
        var id: Self { self }
    }
}
