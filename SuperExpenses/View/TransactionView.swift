//
//  TransactionView.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/11/23.
//

import SwiftData
import SwiftUI

struct TransactionView: View {
    let transaction: Transaction
    var body: some View {
        HStack {
            Image(systemName: transaction.kind == .income ? "arrow.up.right.circle.fill" : "arrow.down.left.circle.fill" )
                .font(.headline)
                .foregroundStyle(transaction.kind == .income ? .green : .red)
            VStack(alignment: .leading) {
                Text(transaction.name)
                    .font(.headline)
                    .lineLimit(1)
                Text(transaction.kind.rawValue.capitalized)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text(transaction.amount.formatted(.localCurrency))
                .font(.body)
                .foregroundStyle(transaction.kind == .income ? .green : .red)
        }
        .padding(.vertical, 8)
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview("Transactions") {
    TransactionView(transaction: Transaction.computer)
        .modelContainer(PreviewSampleData.container)
}
