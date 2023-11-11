//
//  FormatStyle + Extension.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/11/23.
//

import Foundation

extension FormatStyle where Self == FloatingPointFormatStyle<Double>.Currency {
    static var localCurrency: Self {
        .currency(code: Locale.current.currency?.identifier ?? "USD")
    }
}
