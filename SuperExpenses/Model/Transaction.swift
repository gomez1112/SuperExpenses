//
//  Transaction.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/11/23.
//

import Foundation
import SwiftData


@Model
final class Transaction {
    var amount: Double
    var kind: Kind
    var classification: Classification
    var category: Category?
    var user: User
    var date: Date = Date()
    var detail: String?
    
    init(amount: Double, kind: Kind, classification: Classification, category: Category? = nil, user: User, detail: String? = nil) {
        self.amount = amount
        self.kind = kind
        self.classification = classification
        self.category = category
        self.user = user
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
