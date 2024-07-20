//
//  extensions.swift
//  week_1_program
//
//  Created by Akha on 09.05.2024.
//

import Foundation
import SwiftUI

extension Color {
    static let background = Color("Colors/Hintergrund")
    static let icon = Color("Colors/Icon")
    static let text = Color("Colors/Text")
    static let systemBackground = Color(uiColor: .systemBackground) // what this does?
}

extension Transaction {
    func getDate(dateformat: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateformat
        return dateFormatter.date(from: date)
    }
}

extension Date: Strideable {
    func formatted() -> String {
        return self.formatted(.dateTime.year().month().day())
    }
}

extension Double {
    func roundedTo2() -> Double {
        return (self * 100).rounded() / 100
    }
}
