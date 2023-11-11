//
//  Home.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/11/23.
//

import SwiftData
import SwiftUI

struct Home: View {
    @Query(sort: \Transaction.date) private var transactions: [Transaction]
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        StatisticsCard(title: "Total Income", value: totalIncome, color: .green)
                        StatisticsCard(title: "Total Expenses", value: totalExpenses, color: .red)
                    }
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Recent Transactions")
                            .font(.title2)
                            .fontWeight(.bold)
                        ForEach(transactions.prefix(7)) { transaction in
                            TransactionView(transaction: transaction)
                        }
                    }
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    var totalIncome: Double {
        transactions.filter { $0.kind == .income }.map(\.amount).reduce(0,+)
    }
    var totalExpenses: Double {
        transactions.filter { $0.kind == .expense }.map(\.amount).reduce(0,+)
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
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(.thickMaterial, in: RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    Home()
        .modelContainer(PreviewSampleData.container)
}
