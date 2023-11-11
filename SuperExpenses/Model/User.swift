//
//  User.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/11/23.
//

import Foundation
import SwiftData

@Model
final class User {
    var name: String
    var email: String
    var notificationEnabled: Bool
    @Relationship(deleteRule: .cascade, inverse: \Transaction.user)
    var transactions = [Transaction]()
    
    init(name: String, email: String, notificationEnabled: Bool, transactions: [Transaction] = [Transaction]()) {
        self.name = name
        self.email = email
        self.notificationEnabled = notificationEnabled
        self.transactions = transactions
    }
    
    var totalIncome: Double {
        totalAmount(forKind: .income)
    }
    var totalExpenses: Double {
        totalAmount(forKind: .expense)
    }
    var moneyLeft: Double {
        totalIncome - totalExpenses
    }
    private func totalAmount(forKind kind: Transaction.Kind) -> Double {
        transactions.filter { $0.kind == kind }.map(\.amount).reduce(0,+)
    }
}
