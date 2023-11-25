//
//  Home.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/11/23.
//

import SwiftData
import SwiftUI

struct Home: View {
    @Environment(DataModel.self) private var model
    @Environment(\.modelContext) private var context
    @Query(sort: \Transaction.date) private var transactions: [Transaction]
    @State private var showTransactionEditor = false

    var body: some View {
        NavigationStack {
            List {
                HStack {
                    StatisticsCard(title: "Total Income", value: model.totalIncome(transactions: transactions), color: .green)
                    StatisticsCard(title: "Total Expenses", value: model.totalExpenses(transactions: transactions), color: .red)
                }
                Text("Recent Transactions")
                    .font(.title2)
                    .fontWeight(.bold)
                ForEach(transactions.prefix(7)) { transaction in
                    NavigationLink {
                        TransactionDetailView(transaction: transaction)
                    } label: {
                        TransactionView(transaction: transaction)
                    }
                }
                .onDelete { indexSet in
                    model.removeItems(items: transactions, at: indexSet) { transaction in
                        context.delete(transaction)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Home")
        }
    }
}

struct StatisticsCard: View {
    let title: String
    let value: Double
    let color: Color
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .foregroundStyle(color)
            Text(value.formatted(.localCurrency))
                .font(.title.bold())
                .foregroundStyle(color)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(.thickMaterial, in: RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    Home()
        .modelContainer(PreviewSampleData.container)
}
