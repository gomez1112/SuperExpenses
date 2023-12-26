//
//  AppContentColumn.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/11/23.
//

import SwiftUI

struct AppContentColumn: View {
    @Binding var selectedScreen: AppScreen?
    @Binding var selectedTransaction: Transaction?
    @Binding var selectedCategory: Category?
    var body: some View {
        Group {
            if let selectedScreen {
                selectedScreen.destination(transaction: $selectedTransaction, category: $selectedCategory)
            } else {
                ContentUnavailableView("Select from the sidebar", systemImage: "sidebar.left")
            }
            
        }
        #if os(macOS)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background()
        #endif
    }
}

#Preview {
    AppContentColumn(selectedScreen: .constant(.transactions), selectedTransaction: .constant(nil), selectedCategory: .constant(nil))
        .modelContainer(PreviewSampleData.container)
}
