//
//  Transaction+Extension.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/11/23.
//

import Foundation

extension Transaction {
    static let sandwich = Transaction(amount: 12.50, kind: .expense, classification: .personal,user: User(name: "Gerard", email: "gerardgomez11@me.com", notificationEnabled: false))
    static let gas = Transaction(amount: 52.20, kind: .expense, classification: .business, user: User(name: "Gerard", email: "gerardgomez11@me.com", notificationEnabled: false))
    static let paycheck = Transaction(amount: 2000.50, kind: .income, classification: .personal, user: User(name: "Gerard", email: "gerardgomez11@me.com", notificationEnabled: false))
    static let rent = Transaction(amount: 1950.50, kind: .expense, classification: .personal, user: User(name: "Gerard", email: "gerardgomez11@me.com", notificationEnabled: false))
    static let overtime = Transaction(amount: 800, kind: .income, classification: .personal, user: User(name: "Gerard", email: "gerardgomez11@me.com", notificationEnabled: false))
    static let books = Transaction(amount: 120.50, kind: .expense, classification: .business, user: User(name: "Gerard", email: "gerardgomez11@me.com", notificationEnabled: false))
    static let computer = Transaction(amount: 1223.50, kind: .expense, classification: .business, user: User(name: "Gerard", email: "gerardgomez11@me.com", notificationEnabled: false))
    static let movie = Transaction(amount: 30.50, kind: .expense, classification: .personal, user: User(name: "Gerard", email: "gerardgomez11@me.com", notificationEnabled: false))
}
