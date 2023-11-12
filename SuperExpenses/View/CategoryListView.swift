//
//  CategoryListView.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/11/23.
//

import SwiftData
import SwiftUI

struct CategoryListView: View {
    @Query private var categories: [Category]
    @Binding var selectedCategory: Category?
    
    var body: some View {
        NavigationStack {
            List(selection: $selectedCategory) {
                ForEach(categories) { category in
                    NavigationLink {
                        AllTransactions(category: category)
                    } label: {
                        Text(category.name.capitalized)
                    }
                    
                }
            }
            .navigationTitle("Categories")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


#Preview {
    CategoryListView(selectedCategory: .constant(nil))
        .modelContainer(PreviewSampleData.container)
}
