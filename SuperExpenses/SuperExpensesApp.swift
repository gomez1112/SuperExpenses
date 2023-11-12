//
//  SuperExpensesApp.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/11/23.
//

import SwiftData
import SwiftUI

@main
struct SuperExpensesApp: App {
    @State private var model = DataModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environment(model)
        .modelContainer(for: [Category.self, Transaction.self])
    }
}
