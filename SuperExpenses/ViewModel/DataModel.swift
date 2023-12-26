//
//  DataModel.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/12/23.
//

import Algorithms
import Foundation
import Observation
import SwiftData


@Observable
final class DataModel {
    func totalAmount(for kind: Transaction.Kind, in transactions: [Transaction]) -> Double {
        transactions.filter { $0.kind == kind }.map(\.amount).reduce(0, +)
    }
    func removeItems<T>(items: [T], at indexSet: IndexSet, deleteAction: (T) -> Void) {
        indexSet.forEach { index in
            deleteAction(items[index])
        }
    }
    
    func transactionsByCategory(allTransactions: [Transaction], category: Category?) -> [Transaction] {
        allTransactions.filter { $0.category == category}
    }
    func yearGroupedTransactions(transactions: [Transaction]) -> [YearlyTransactions] {
        let calendar = Calendar.current
        // Group by year first
        let groupedByYear = transactions.chunked(on: { calendar.component(.year, from: $0.date) })
        
        return groupedByYear.map { (year, yearlyGroup) in
            // Group by month within each year
            let monthlyGroups = yearlyGroup.chunked(on: { calendar.component(.month, from: $0.date) })
            
            let monthlyTransactions = monthlyGroups.map { (month, monthlyGroup) in
                let monthDate = calendar.date(from: DateComponents(year: year, month: month))!
                return MonthlyTransactions(month: monthDate, transactions: Array(monthlyGroup))
            }.sorted { $0.month < $1.month }
            
            let yearDate = calendar.date(from: DateComponents(year: year))!
            return YearlyTransactions(year: yearDate, monthlyTransactions: monthlyTransactions)
        }.sorted { $0.year < $1.year }
    }
}
