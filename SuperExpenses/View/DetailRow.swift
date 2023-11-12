//
//  DetailRow.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/12/23.
//

import SwiftUI

struct DetailRow: View {
    var label: String
    var value: String
    var style: DateFormatter.Style = .none
    
    init(label: String, value: String) {
        self.label = label
        self.value = value
    }
    
    init(label: String, value: Date, style: DateFormatter.Style) {
        self.label = label
        self.value = DateFormatter.localizedString(from: value, dateStyle: style, timeStyle: .none)
    }
    
    var body: some View {
        HStack {
            Text(label)
                .font(.headline)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .font(.body)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    DetailRow(label: "", value: "")
}
