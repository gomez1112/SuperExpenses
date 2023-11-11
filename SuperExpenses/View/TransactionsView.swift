//
//  TransactionsView.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/11/23.
//

import SwiftData
import SwiftUI

struct TransactionsView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Transaction.amount, order: .reverse) private var transactions: [Transaction]
    @Query private var categories: [Category]
    var body: some View {
        NavigationStack {
            List {
                ForEach(categories) { category in
                    Section(category.name) {
                        ForEach(category.transactions) { transaction in
                            NavigationLink(value: transaction) {
                                TransactionView(transaction: transaction)
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: Transaction.self) { transaction in
                TransactionDetailView(transaction: transaction)
            }
        }
    }
}

#Preview {
    TransactionsView()
        .modelContainer(PreviewSampleData.container)
}
