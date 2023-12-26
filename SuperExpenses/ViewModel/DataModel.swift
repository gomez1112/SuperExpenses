//
//  DataModel.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/12/23.
//

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
        let groupedByYear = Dictionary(grouping: transactions) { (transaction) -> Date in
            let yearComponent = Calendar.current.component(.year, from: transaction.date)
            return Calendar.current.date(from: DateComponents(year: yearComponent, month: 1, day: 1))!
        }
        
        return groupedByYear.map { year, transactions in
            let monthlyGroups = Dictionary(grouping: transactions) { (transaction) -> Date in
                Calendar.current.startOfDay(for: Calendar.current.date(from: DateComponents(year: Calendar.current.component(.year, from: transaction.date), month: Calendar.current.component(.month, from: transaction.date)))!)
            }
            
            let monthlyTransactions = monthlyGroups.map { month, transactions in
                MonthlyTransactions(month: month, transactions: transactions)
            }.sorted { $0.month < $1.month }
            
            return YearlyTransactions(year: year, monthlyTransactions: monthlyTransactions)
        }.sorted { $0.year < $1.year }
    }
}
