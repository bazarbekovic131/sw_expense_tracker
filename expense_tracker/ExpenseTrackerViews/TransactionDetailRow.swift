//
//  TransactionRow.swift
//  week_1_program
//
//  Created by Akha on 20.07.2024.
//

import SwiftUI

struct TransactionDetailRow: View {
    var icon: String
    var title: String
    var text: String
     
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon).font(.title).frame(width: 32, height: 32) // MARK: icon
            
            VStack(alignment: .leading) {
                Text(title) // MARK: title
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(text) // MARK: text
                    .lineLimit(1)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    TransactionDetailRow(icon: "house", title: "hello", text: "world")
}
