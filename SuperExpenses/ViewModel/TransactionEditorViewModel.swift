//
//  TransactionEditorViewModel.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/12/23.
//

import Foundation
import Observation
import SwiftData

extension TransactionEditor {
    @Observable
    final class ViewModel {
        var name = ""
        var amount = 0.0
        var selectedKind: Transaction.Kind = .expense
        var selectedClassification: Transaction.Classification = .personal
        var selectedCategory: Category?
        var selectedDate: Date = Date()
        var detail: String?
        
        func save(transaction: Transaction?, context: ModelContext) {
            if let transaction {
                transaction.name = name
                transaction.amount = amount
                transaction.kind = selectedKind
                transaction.classification = selectedClassification
                transaction.category = selectedCategory
                transaction.date = selectedDate
                transaction.detail = detail
            } else {
                let newTransaction = Transaction(name: name, amount: amount, kind: selectedKind, classification: selectedClassification, date: selectedDate, detail: detail)
                newTransaction.category = selectedCategory
                context.insert(newTransaction)
                
            }
        }
    }
}
