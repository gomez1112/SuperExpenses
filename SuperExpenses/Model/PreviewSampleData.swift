//
//  PreviewModelContainer.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/11/23.
//

import SwiftData

actor PreviewSampleData {
    static var container: ModelContainer = {
        createContainer
    }()
    static private var createContainer: ModelContainer {
        let schema = Schema([Transaction.self, Category.self])
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        do {
            let container = try ModelContainer(for: schema, configurations: [configuration])
            Task { @MainActor in
                Category.insertSampleData(context: container.mainContext)
            }
            return container
        } catch {
            fatalError("Cannot load container: \(error.localizedDescription)")
        }
    }
}
