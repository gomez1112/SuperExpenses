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
            TransactionListView(selectedTransaction: $selectedTransaction)
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
struct YearlyTransactions {
    let year: Date
    let monthlyTransactions: [MonthlyTransactions]
}

struct MonthlyTransactions {
    let month: Date
    let transactions: [Transaction]
}

#Preview {
    TransactionsView(selectedTransaction: .constant(nil))
        .modelContainer(PreviewSampleData.container)
}
