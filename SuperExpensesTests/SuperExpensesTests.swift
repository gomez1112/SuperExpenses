//
//  SuperExpensesTests.swift
//  SuperExpensesTests
//
//  Created by Gerard Gomez on 12/10/23.
//

import XCTest
@testable import SuperExpenses
import SwiftData

@MainActor
final class SuperExpensesTests: XCTestCase {
    
    func testAppStartsEmpty() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let schema = Schema([Transaction.self, Category.self])
        _ = try ModelContainer(for: schema, configurations: config)
        let sut = TransactionEditor.ViewModel()
        XCTAssertEqual(sut.amount, 0, "There should be $0")
    }

}
