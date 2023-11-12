//
//  AppTabView.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/11/23.
//

import SwiftUI

struct AppTabView: View {
    @Binding var selectedScreen: AppScreen?
    @Binding var selectedTransaction: Transaction?
    @Binding var selectedCategory: Category?
    var body: some View {
        TabView(selection: $selectedScreen ) {
            ForEach(AppScreen.allCases) { screen in
                screen.destination(transaction: $selectedTransaction, category: $selectedCategory)
                    .tag(screen as AppScreen?)
                    .tabItem {
                        screen.label
                    }
            }
        }
    }
}

#Preview {
    AppTabView(selectedScreen: .constant(.transactions), selectedTransaction: .constant(nil), selectedCategory: .constant(nil))
        .modelContainer(PreviewSampleData.container)
}
