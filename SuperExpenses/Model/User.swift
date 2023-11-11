//
//  Profile.swift
//  SuperExpenses
//
//  Created by Gerard Gomez on 11/11/23.
//

import Foundation
import SwiftData

@Model
final class Profile {
    var name: String
    var email: String
    var notificationEnabled: Bool
    @Relationship(deleteRule: .cascade)
    var transactions = [Transaction]()
}
