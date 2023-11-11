//
//  Statistics.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/11/23.
//

import Charts
import SwiftData
import SwiftUI

struct Statistics: View {
    @Query private var transactions: [Transaction]
    var body: some View {
        ScrollView {
            VStack {
                Text("Financial Overview")
                    .font(.title)
                Chart {
                    ForEach(transactions) { transaction in
                        BarMark(x: .value("Category", transaction.category?.name.capitalized ?? ""), y: .value("Amount", transaction.amount))
                            .foregroundStyle(by: .value("Kind", transaction.kind.rawValue.capitalized))
                    }
                }
                .frame(height: 300)
                .padding()
                Chart {
                    ForEach(transactions.filter { $0.kind == .expense }) { transaction in
                        SectorMark(angle: .value("Amount", transaction.amount))
                            .foregroundStyle(by: .value("Category", transaction.category?.name.capitalized ?? ""))
                    }
                }
                .frame(height: 300)
                .padding()
                Chart {
                    ForEach(transactions) { transaction in
                        BarMark(x: .value("Classification", transaction.classification.rawValue.capitalized), y: .value("Amount", transaction.amount))
                            .foregroundStyle(by: .value("Category", transaction.category?.name.capitalized ?? ""))
                    }
                }
                .frame(height: 300)
                .padding()
            }
        }
    }
}

#Preview {
    Statistics()
        .modelContainer(PreviewSampleData.container)
}
