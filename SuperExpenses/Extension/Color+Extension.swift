//
//  Color+Extension.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/11/23.
//

import Foundation
import SwiftUI

extension Color {
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        UIColor(self).colorComponents
    }
    var rgbaColor: CodableColor {
        CodableColor(r: components.red, g: components.green, b: components.blue, a: components.alpha)
    }
    init(_ rgbaColor: CodableColor) {
        self.init(red: Double(rgbaColor.r), green: Double(rgbaColor.g), blue: Double(rgbaColor.b), opacity: Double(rgbaColor.a))
    }
}
