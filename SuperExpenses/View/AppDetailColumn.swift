//
//  AppDetailColumn.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/11/23.
//

import SwiftData
import SwiftUI

struct AppDetailColumn: View {
    @Binding var selectedTransaction: Transaction?
    @Binding var selectedCategory: Category?
    var body: some View {
        Group {
            if let selectedTransaction {
                TransactionDetailView(transaction: selectedTransaction)
            }
            if let selectedCategory{
                AllTransactions(category: selectedCategory)
            } else {
                ContentUnavailableView("Select a Transaction", systemImage: "creditcard")
            }
        }
#if os(macOS)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background()
#endif
    }
}

#Preview {
    AppDetailColumn(selectedTransaction: .constant(nil), selectedCategory: .constant(nil))
}
