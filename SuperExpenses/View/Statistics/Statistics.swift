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
    let chartTypes: [ChartType] = [.bar, .sector, .line]
    var body: some View {
        NavigationStack {
            List {
                ForEach(chartTypes) { chart in
                    Section {
                        NavigationLink(destination: chart.detailView()) {
                            chart.chartView(transactions: transactions)
                                .frame(height: 300)
                                .padding()
                        }
                    }
                }
            }
            .navigationDestination(for: ChartType.self) { chart in
                chart.detailView()
            }
            .navigationTitle("Financial Overview")
        }
    }
}

#Preview {
    Statistics()
        .modelContainer(PreviewSampleData.container)
}

struct BarMarkView: View {
    let transactions: [Transaction]
    var body: some View {
        Chart {
            ForEach(transactions) { transaction in
                BarMark(x: .value("Category", transaction.category?.name.capitalized ?? ""), y: .value("Amount", transaction.amount))
                    .foregroundStyle(by: .value("Kind", transaction.kind.rawValue.capitalized))
            }
        }
    }
}

struct SectorMarkView: View {
    let transactions: [Transaction]
    var body: some View {
        Chart {
            ForEach(transactions.filter { $0.kind == .expense }) { transaction in
                SectorMark(angle: .value("Amount", transaction.amount),
                           innerRadius: .ratio(0.5),
                           outerRadius: .inset(10),
                           angularInset: 1)
                .foregroundStyle(by: .value("Category", transaction.category?.name.capitalized ?? ""))
                .annotation(position: .overlay) {
                    Text(transaction.amount.formatted(.localCurrency))
                }
            }
        }
        
    }
}

struct LineMarkView: View {
    let transactions: [Transaction]
    var body: some View {
        Chart {
            ForEach(transactions) { transaction in
                LineMark(x: .value("Date", transaction.date), y: .value("Amount", transaction.amount))
            }
        }
    }
}
enum ChartType: Identifiable {
    case bar
    case sector
    case line
    var id: Self { self }
    
    @ViewBuilder
    func chartView(transactions: [Transaction]) -> some View {
        switch self {
            case .bar:
                BarMarkView(transactions: transactions)
            case .sector:
                SectorMarkView(transactions: transactions)
            case .line:
                LineMarkView(transactions: transactions)
        }
    }
    @ViewBuilder
    func detailView() -> some View {
        switch self {
            case .bar:
                BarMarkDetailView()
            case .sector:
                SectorMarkDetailView()
            case .line:
                LineMarkDetailView()
        }
    }
}
