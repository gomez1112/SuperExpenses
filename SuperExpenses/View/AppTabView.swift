//
//  AppTabView.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/11/23.
//

import SwiftUI

struct AppTabView: View {
    @Binding var selectedScreen: AppScreen?
    var body: some View {
        TabView(selection: $selectedScreen ) {
            ForEach(AppScreen.allCases) { screen in
                screen.destination()
                    .tag(screen as AppScreen?)
                    .tabItem {
                        screen.label
                    }
            }
        }
    }
}

#Preview {
    AppTabView(selectedScreen: .constant(.transactions))
        .modelContainer(PreviewSampleData.container)
}
