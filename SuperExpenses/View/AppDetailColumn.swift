//
//  AppDetailColumn.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/11/23.
//

import SwiftUI

struct AppDetailColumn: View {
    var body: some View {
        TransactionDetailView()
        #if os(macOS)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background()
        #endif
    }
}

#Preview {
    AppDetailColumn()
}
