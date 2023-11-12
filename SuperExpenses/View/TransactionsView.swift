//
//  TransactionsView.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/11/23.
//

import SwiftData
import SwiftUI
import WidgetKit

struct TransactionsView: View {
    @Binding var selectedTransaction: Transaction?
    var body: some View {
        NavigationStack {
            TransactionsListView(selectedTransaction: $selectedTransaction)
                .navigationTitle("Transactions")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct YearSection: View {
    let year: Date
    let monthlyTransactions: [Date: [Transaction]]
    let categories: [Category]
    
    var body: some View {
        Section(year.formatted(date: .numeric, time: .omitted)) {
            ForEach(monthlyTransactions.keys.sorted(), id: \.self) { month in
                if let transactions = monthlyTransactions[month] {
                    MonthSection(month: month, transactions: transactions, categories: categories)
                        .animation(nil, value: month)
                }
                
            }
        }
    }
}

struct MonthSection: View {
    let month: Date
    let transactions: [Transaction]
    let categories: [Category]
    
    var body: some View {
        DisclosureGroup {
            ForEach(categories, id: \.self) { category in
                if let categoryTransaction = transactionsForCategory(transactions, category: category) {
                    Section(category.name) {
                        ForEach(categoryTransaction, id: \.id) { transaction in
                            NavigationLink {
                                TransactionDetailView(transaction: transaction)
                            } label: {
                                TransactionView(transaction: transaction)
                            }
                        }
                    }
                }
            }
            
        } label: {
            Text(month.formatted(.dateTime.month(.wide)))
        }
    }
    
    private func transactionsForCategory(_ transactions: [Transaction], category: Category) -> [Transaction]? {
        let filteredTransactions = transactions.filter { $0.category == category }
        return filteredTransactions.isEmpty ? nil : filteredTransactions
    }
}
private struct YearlyTransactions {
    let year: Date
    let monthlyTransactions: [MonthlyTransactions]
}

private struct MonthlyTransactions {
    let month: Date
    let transactions: [Transaction]
}

#Preview {
    TransactionsView(selectedTransaction: .constant(nil))
        .modelContainer(PreviewSampleData.container)
}

struct TransactionsListView: View {
    var category: Category?
    @Environment(\.modelContext) private var context
    @Query private var categories: [Category]
    @State private var isEditorPresented = false
    @Query(sort: \Transaction.date) private var transactions: [Transaction]
    @Binding var selectedTransaction: Transaction?
    
    var body: some View {
        List(selection: $selectedTransaction) {
            ForEach(yearGroupedTransactions, id: \.year) { yearlyTransactions in
                Section {
                    ForEach(yearlyTransactions.monthlyTransactions, id: \.month) { monthlyTransactions in
                        MonthSection(month: monthlyTransactions.month, transactions: monthlyTransactions.transactions, categories: categories)
                    }
                    .onDelete(perform: removeTransactions)
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
    private var yearGroupedTransactions: [YearlyTransactions] {
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
    private func removeTransactions(at indexSet: IndexSet) {
        for index in indexSet {
            let transactionToDelete = transactions[index]
            context.delete(transactionToDelete)
        }
    }
    struct AddTransactionButton: View {
        @Binding var isActive: Bool
        var body: some View {
            Button {
                isActive = true
                WidgetCenter.shared.reloadAllTimelines()
            } label: {
                Label("Add a transaction", systemImage: "plus")
                    .help("Add a transaction")
            }
        }
    }
}
