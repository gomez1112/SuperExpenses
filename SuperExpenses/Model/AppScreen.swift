//
//  AppScreen.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/11/23.
//

import SwiftUI

enum AppScreen: Identifiable, Hashable, CaseIterable {
    var id: Self { self }
    case home
    case transactions
    case category
    case statistics
    case profile
    
    @ViewBuilder
    var label: some View {
        switch self {
            case .home:
                Label("Home", systemImage: "house.circle")
            case .transactions:
                Label("Transactions", systemImage: "creditcard.circle")
            case .category:
                Label("Category", systemImage: "car")
            case .statistics:
                Label("Statistics", systemImage: "chart.pie")
            case .profile:
                Label("Profile", systemImage: "person.crop.circle")
        }
    }
    
    @ViewBuilder
    func destination(transaction: Binding<Transaction?>, category: Binding<Category?>) -> some View {
        switch self {
            case .home:
                Home()
            case .transactions:
                TransactionsView(selectedTransaction: transaction)
            case .category:
                CategoryListView(selectedCategory: category)
            case .statistics:
                Statistics()
            case .profile:
                Profile()
        }
    }
}

