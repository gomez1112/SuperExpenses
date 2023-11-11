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
    var body: some View {
        if prefersTabNavigation {
            AppTabView(selectedScreen: $selectedScreen)
        } else {
            NavigationSplitView {
                AppSidebarList(selectedScreen: $selectedScreen)
                    .navigationTitle("SuperExpenses")
            } content: {
                AppContentColumn(selectedScreen: $selectedScreen)
            } detail: {
                AppDetailColumn()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(PreviewSampleData.container)
}
