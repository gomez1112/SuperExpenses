//
//  Category+Extension.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/11/23.
//

import Foundation
import SwiftData
import SwiftUI

extension Category {
    static let income = Category(name: "Income", symbol: "dollarsign.circle", color: Color.green.rgbaColor)
    static let bill = Category(name: "Bill", symbol: "creditcard", color: Color.orange.rgbaColor)
    static let enterntaiment = Category(name: "Entertaiment", symbol: "popcorn.circle.fill", color: Color.brown.rgbaColor)
    static let groceries = Category(name: "Groceries", symbol: "carrot", color: Color.purple.rgbaColor)
    static let education = Category(name: "Education", symbol: "book.circle", color: Color.yellow.rgbaColor)
    static let vehicle = Category(name: "Vehicle", symbol: "car.circle", color: Color.pink.rgbaColor)
    
    static var preview: [Category] {
        [income, bill, enterntaiment, groceries, education, vehicle]
    }
    
    static func insertSampleData(context: ModelContext) {
        context.insert(income)
        context.insert(bill)
        context.insert(enterntaiment)
        context.insert(groceries)
        context.insert(education)
        context.insert(vehicle)
        
        context.insert(Transaction.sandwich)
        context.insert(Transaction.gas)
        context.insert(Transaction.paycheck)
        context.insert(Transaction.rent)
        context.insert(Transaction.overtime)
        context.insert(Transaction.books)
        context.insert(Transaction.computer)
        context.insert(Transaction.movie)
        
        Transaction.sandwich.category = groceries
        Transaction.gas.category = vehicle
        Transaction.paycheck.category = income
        Transaction.rent.category = bill
        Transaction.overtime.category = income
        Transaction.books.category = education
        Transaction.computer.category = education
        Transaction.movie.category = enterntaiment
    }
    static func reloadSampleData(context: ModelContext) {
        do {
            try context.delete(model: Category.self)
            insertSampleData(context: context)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
