//
//  TransactionListView.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/12/23.
//

import SwiftData
import SwiftUI
#if os(iOS) || os(macOS)
import WidgetKit
#endif

struct TransactionListView: View {
    var category: Category?
    @Environment(DataModel.self) private var model
    @Environment(\.modelContext) private var context
    @Query private var categories: [Category]
    @State private var isEditorPresented = false
    @Query(sort: \Transaction.date) private var transactions: [Transaction]
    @Binding var selectedTransaction: Transaction?
 
    var body: some View {
        List(selection: $selectedTransaction) {
            ForEach(model.yearGroupedTransactions(transactions: transactions), id: \.year) { yearlyTransactions in
                Section {
                    ForEach(yearlyTransactions.monthlyTransactions, id: \.month) { monthlyTransactions in
                        MonthSection(month: monthlyTransactions.month, transactions: monthlyTransactions.transactions, categories: categories)
                    }
                    .onDelete { indexSet in
                        model.removeItems(items: transactions, at: indexSet) { transaction in
                            context.delete(transaction)
                        }
                    }
                } header: {
                    Text(yearlyTransactions.year.formatted(.dateTime.year()))
                }
            }
        }
        .sheet(isPresented: $isEditorPresented) {
            TransactionEditor(transaction: nil)
        }
        .overlay {
            if transactions.isEmpty {
                ContentUnavailableView {
                    Label("No transactions", systemImage: "creditcard")
                } description: {
                    AddTransactionButton(isActive: $isEditorPresented)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                AddTransactionButton(isActive: $isEditorPresented)
            }
        }
    }
    
    struct AddTransactionButton: View {
        @Binding var isActive: Bool
        var body: some View {
            Button {
                isActive = true
                #if os(iOS) || os(macOS)
                WidgetCenter.shared.reloadAllTimelines()
                #endif
            } label: {
                Label("Add a transaction", systemImage: "plus")
                    .help("Add a transaction")
            }
        }
    }
}
#Preview {
    TransactionListView(selectedTransaction: .constant(nil))
}
