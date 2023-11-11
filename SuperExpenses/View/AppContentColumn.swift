//
//  AppContentColumn.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/11/23.
//

import SwiftUI

struct AppContentColumn: View {
    @Binding var selectedScreen: AppScreen?
    var body: some View {
        Group {
            if let selectedScreen {
                selectedScreen.destination()
            } else {
                ContentUnavailableView("Select something from the sidebar", systemImage: "sidebar.left")
            }
        }
        #if os(macOS)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background()
        #endif
    }
}

#Preview {
    AppContentColumn(selectedScreen: .constant(.transactions))
}
