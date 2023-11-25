//
//  AppSidebarList.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/11/23.
//

import SwiftUI

struct AppSidebarList: View {
    @Binding var selectedScreen: AppScreen?
    var body: some View {
        List(selection: $selectedScreen) {
            ForEach(AppScreen.allCases) { screen in
                NavigationLink(value: screen) {
                    screen.label
                }
            }
        }
        .navigationTitle("Super Expense")
    }
}

#Preview {
    AppSidebarList(selectedScreen: .constant(.transactions))
}
