//
//  SuperExpenseWidget.swift
//  SuperExpenseWidget
//
//  Created by Gerard Gomez on 11/12/23.
//

import SwiftData
import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    @MainActor func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), transactions: getTransactions)
    }

    @MainActor func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), transactions: getTransactions)
        completion(entry)
    }

    @MainActor func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
       
        let timeline = Timeline(entries: [SimpleEntry(date: .now, transactions: getTransactions)], policy: .never)
        completion(timeline)
    }
    @MainActor
    private var getTransactions: [Transaction] {
        guard let container = try? ModelContainer(for: Category.self, Transaction.self) else { return [] }
        let threeDaysAgo = Calendar.current.date(byAdding: .day, value: -3, to: Date())!
        var descriptor = FetchDescriptor<Transaction>(predicate: #Predicate { transaction in
            transaction.date >= threeDaysAgo
        })
        descriptor.fetchLimit = 3
        let transactions = try? container.mainContext.fetch(descriptor)
        return transactions ?? []
        
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let transactions: [Transaction]
}

struct SuperExpenseWidgetEntryView : View {
    var entry: Provider.Entry
    var body: some View {
        VStack {
            Text("Most Recent Transactions")
                .font(.title)
            ForEach(entry.transactions) { transaction in
                TransactionView(transaction: transaction)
            }
        }
    }
}

struct SuperExpenseWidget: Widget {
    let kind: String = "SuperExpenseWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                SuperExpenseWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                SuperExpenseWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Recent Transactions Widget")
        .description("This widget shows the 3 most recents transactions.")
    }
}

#Preview(as: .systemSmall) {
    SuperExpenseWidget()
} timeline: {
    SimpleEntry(date: .now, transactions: [Transaction.books])
    SimpleEntry(date: .now, transactions: [Transaction.paycheck])
}
