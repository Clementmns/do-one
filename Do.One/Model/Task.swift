//
//  Task.swift
//  Do.One
//
//  Created by Clément OMNES on 16/03/2025.
//

import SwiftUI

struct Task: Identifiable, Codable {
    var id: UUID = UUID()
    var title: String
    var isCompleted: Bool = false
    var createdAt: Date = Date()
}
