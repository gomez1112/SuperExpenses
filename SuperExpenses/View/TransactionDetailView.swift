//
//  TransactionDetailView.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/11/23.
//

import SwiftUI

struct TransactionDetailView: View {
    var transaction: Transaction?
    var body: some View {
        Group {
            if let transaction {
                VStack {
                    HStack {
                        Text(transaction.kind.rawValue.capitalized)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(transaction.kind == .income ? .green : .red)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(.ultraThinMaterial)
                            .clipShape(.rect(cornerRadius: 8))
                        Spacer()
                        Text(transaction.amount.formatted(.localCurrency))
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(transaction.kind == .income ? .green : .red)
                    }
                    .padding(.top)
                    Divider()
                        .padding(.vertical)
                    Group {
                        DetailRow(label: "Category", value: transaction.category?.name ?? "No Category")
                        DetailRow(label: "Date", value: transaction.date, style: .medium)
                        if let detail = transaction.detail, !detail.isEmpty {
                            DetailRow(label: "Detail", value: detail)
                        }
                    }
                    .padding(.horizontal)
                    Spacer()
                }
                .padding()
                .navigationTitle(transaction.name)
                .navigationBarTitleDisplayMode(.inline)
            } else {
                ContentUnavailableView("Select a transaction", systemImage: "creditcard")
            }
        }
    }
}

struct DetailRow: View {
    var label: String
    var value: String
    var style: DateFormatter.Style = .none
    
    init(label: String, value: String) {
        self.label = label
        self.value = value
    }
    
    init(label: String, value: Date, style: DateFormatter.Style) {
        self.label = label
        self.value = DateFormatter.localizedString(from: value, dateStyle: style, timeStyle: .none)
    }
    
    var body: some View {
        HStack {
            Text(label)
                .font(.headline)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .font(.body)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    TransactionDetailView(transaction: Transaction.rent)
        .modelContainer(PreviewSampleData.container)
}
