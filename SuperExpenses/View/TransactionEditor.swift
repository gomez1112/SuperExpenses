//
//  TransactionEditor.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/11/23.
//

import Observation
import SwiftData
import SwiftUI

struct TransactionEditor: View {
    @State private var viewModel = ViewModel()
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    let transaction: Transaction?
    @Query private var categories: [Category]
    
    private var editorTitle: String {
        transaction == nil ? "Add Transaction" : "Edit Transaction"
    }
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $viewModel.name)
                TextField("Amount", value: $viewModel.amount, format: .number)
                Picker("Transaction Type", selection: $viewModel.selectedKind) {
                    ForEach(Transaction.Kind.allCases) { kind in
                        Text(kind.rawValue.capitalized)
                            .tag(kind)
                    }
                }
                .pickerStyle(.segmented)
                Picker("Transaction Classification", selection: $viewModel.selectedClassification) {
                    ForEach(Transaction.Classification.allCases) { classification in
                        Text(classification.rawValue.capitalized)
                            .tag(classification)
                    }
                }
                .pickerStyle(.segmented)
                Picker("Category", selection: $viewModel.selectedCategory) {
                    Text("Select a category")
                        .tag(nil as Category?)
                    ForEach(categories) { category in
                        Text(category.name)
                            .tag(category as Category?)
                    }
                }
                DatePicker("Select Date", selection: $viewModel.selectedDate)
                TextField("Detail", text: $viewModel.detail.bound)
            }
            .formStyle(.grouped)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(editorTitle)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        withAnimation {
                            viewModel.save(transaction: transaction, context: context)
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
                viewModel.name = transaction.name
                viewModel.amount = transaction.amount
                viewModel.selectedKind = transaction.kind
                viewModel.selectedClassification = transaction.classification
                viewModel.selectedCategory = transaction.category
                viewModel.selectedDate = transaction.date
                viewModel.detail = transaction.detail
            }
        }
    }
}

#Preview {
    TransactionEditor(transaction: Transaction.books)
        .modelContainer(PreviewSampleData.container)
}
