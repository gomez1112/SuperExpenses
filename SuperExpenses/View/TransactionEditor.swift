//
//  TransactionEditor.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/11/23.
//

import SwiftData
import SwiftUI

struct TransactionEditor: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    let transaction: Transaction?
    @Query private var categories: [Category]
    @State private var name = ""
    @State private var amount = 0.0
    @State private var selectedKind: Transaction.Kind = .expense
    @State private var selectedClassification: Transaction.Classification = .personal
    @State private var selectedCategory: Category?
    @State private var selectedDate: Date = Date()
    @State private var detail: String?
    
    private var editorTitle: String {
        transaction == nil ? "Add Transaction" : "Edit Transaction"
    }
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                TextField("Amount", value: $amount, format: .number)
                Picker("Transaction Type", selection: $selectedKind) {
                    ForEach(Transaction.Kind.allCases) { kind in
                        Text(kind.rawValue.capitalized)
                            .tag(kind)
                    }
                }
                .pickerStyle(.segmented)
                Picker("Transaction Classification", selection: $selectedClassification) {
                    ForEach(Transaction.Classification.allCases) { classification in
                        Text(classification.rawValue.capitalized)
                            .tag(classification)
                    }
                }
                .pickerStyle(.segmented)
                Picker("Category", selection: $selectedCategory) {
                    Text("Select a category")
                        .tag(nil as Category?)
                    ForEach(categories) { category in
                        Text(category.name)
                            .tag(category as Category?)
                    }
                }
                DatePicker("Select Date", selection: $selectedDate)
                TextField("Detail", text: $detail.bound)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(editorTitle)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        withAnimation {
                            save()
                            dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            if let transaction {
                name = transaction.name
                amount = transaction.amount
                selectedKind = transaction.kind
                selectedClassification = transaction.classification
                selectedDate = transaction.date
                detail = transaction.detail
            }
        }
    }
    private func save() {
        if let transaction {
            transaction.name = name
            transaction.amount = amount
            transaction.kind = selectedKind
            transaction.classification = selectedClassification
            transaction.date = selectedDate
            transaction.detail = detail
        } else {
            let newTransaction = Transaction(name: name, amount: amount, kind: selectedKind, classification: selectedClassification, date: selectedDate, detail: detail)
            newTransaction.category = selectedCategory
            context.insert(newTransaction)
            
        }
    }
}

#Preview {
    TransactionEditor(transaction: Transaction.books)
        .modelContainer(PreviewSampleData.container)
}
//var name: String
//var amount: Double
//var kind: Kind
//var classification: Classification
//var category: Category?
//var date: Date = Date()
//var detail: String?
