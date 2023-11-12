//
//  AllTransactions.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/11/23.
//

import SwiftData
import SwiftUI

struct AllTransactions: View {
    @Environment(DataModel.self) private var model
    @Environment(\.modelContext) private var context
    @Query private var allTransactions: [Transaction]
    var category: Category?

    var body: some View {
        NavigationStack {
            List {
                ForEach(transactionsByCategory) { transaction in
                    NavigationLink {
                        TransactionDetailView(transaction: transaction)
                    } label: {
                        TransactionView(transaction: transaction)
                    }
                }
                .onDelete { indexSet in
                    model.removeItems(items: transactionsByCategory, at: indexSet) { transaction in
                        context.delete(transaction)
                    }
                }
            }
            .navigationTitle("All Transactions")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    private var transactionsByCategory: [Transaction] {
        model.transactionsByCategory(allTransactions: allTransactions, category: category)
    }
}

#Preview {
    AllTransactions()
        .modelContainer(PreviewSampleData.container)
}
