//
//  Transaction+Extension.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/11/23.
//

import Foundation

extension Transaction {
    static let sandwich = Transaction(name: "Sandwich", amount: 12.50, kind: .expense, classification: .personal, date: .now)
    static let gas = Transaction(name: "Gas", amount: 52.20, kind: .expense, classification: .business, date: Date().addingTimeInterval(60*60*24*30))
    static let paycheck = Transaction(name: "Paycheck", amount: 2000.50, kind: .income, classification: .personal, date: Date().addingTimeInterval(60*60*24*30*2))
    static let rent = Transaction(name: "Rent", amount: 1950.50, kind: .expense, classification: .personal, date: Date().addingTimeInterval(60*60*24*30*10))
    static let overtime = Transaction(name: "Overtime", amount: 800, kind: .income, classification: .personal, date: Date().addingTimeInterval(60*60*24*30*20))
    static let books = Transaction(name: "Books", amount: 120.50, kind: .expense, classification: .business, date: Date().addingTimeInterval(60*60*24*15))
    static let computer = Transaction(name: "Computer", amount: 1223.50, kind: .expense, classification: .business, date: Date().addingTimeInterval(60*60*24*30*2))
    static let movie = Transaction(name: "Movie", amount: 30.50, kind: .expense, classification: .personal)
    
    static var preview: [Transaction] {
        [sandwich, gas, paycheck, rent, overtime, books, computer, movie ]
    }
}
