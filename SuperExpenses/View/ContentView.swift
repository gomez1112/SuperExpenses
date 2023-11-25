//
//  ContentView.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/11/23.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    @State private var selectedScreen: AppScreen?
    @State private var selectedTransaction: Transaction?
    @State private var selectedCagory: Category?
   
    var body: some View {
        if prefersTabNavigation {
            AppTabView(selectedScreen: $selectedScreen, selectedTransaction: $selectedTransaction, selectedCategory: $selectedCagory)
        } else {
            NavigationSplitView {
                AppSidebarList(selectedScreen: $selectedScreen)
            } content: {
                AppContentColumn(selectedScreen: $selectedScreen, selectedTransaction: $selectedTransaction, selectedCategory: $selectedCagory)
            } detail: {
                AppDetailColumn(selectedTransaction: $selectedTransaction, selectedCategory: $selectedCagory)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(PreviewSampleData.container)
}
