//
//  AllTransactions.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/11/23.
//

import SwiftData
import SwiftUI

struct AllTransactions: View {
    @Query private var allTransactions: [Transaction]
    let category: Category
    var transactions: [Transaction] {
        allTransactions.filter { $0.category == category}
    }
    var body: some View {
        List {
            ForEach(transactions) { transaction in
                NavigationLink(value: transaction) {
                    TransactionView(transaction: transaction)
                }
            }
        }
        .navigationDestination(for: Transaction.self) { transaction in
            TransactionDetailView(transaction: transaction)
        }
        .navigationTitle(category.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AllTransactions(category: Category.bill)
        .modelContainer(PreviewSampleData.container)
}
