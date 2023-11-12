//
//  CategoryListView.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/11/23.
//

import SwiftData
import SwiftUI

struct CategoryListView: View {
    @Environment(\.modelContext) private var context
    @Query private var categories: [Category]
    
    var body: some View {
        NavigationStack {
            List {
                ListCategories(categories: categories)
            }
            .navigationDestination(for: Category.self) { category in
                AllTransactions(category: category)
            }
            .navigationTitle("Categories")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
private struct ListCategories: View {
    var categories: [Category]
    var body: some View {
        ForEach(categories) { category in
            NavigationLink(value: category) {
                Text(category.name)
            }
        }
    }
}
#Preview {
    CategoryListView()
        .modelContainer(PreviewSampleData.container)
}
