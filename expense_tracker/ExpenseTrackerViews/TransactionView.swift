//
//  TransactionView.swift
//  week_1_program
//
//  Created by Akha on 09.05.2024.
//

import SwiftUI

struct TransactionView: View {
    var transaction: Transaction
    
    var body: some View {
        List {
            VStack(spacing: 6) {
                Text(transaction.signedAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")) // TODO: i carry this around everywhere. There must be a method to store it somewhere globally (static) and access it everywhere
                Text(transaction.merchant)
                    .lineLimit(1)
                Text(transaction.parsedDate, format: .dateTime.year().month(.wide).day())
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .listRowSeparator(.hidden, edges: .top)
            .padding(.vertical, 16)
            
            TransactionDetailRow(icon: "cart", title: "Seller", text: transaction.merchant)
            
            TransactionDetailRow(icon: "calendar.badge.clock", title: "Date", text: transaction.parsedDate.formatted(.dateTime.year().month(.wide).day().weekday(.wide)))
            TransactionDetailRow(icon: "building.columns", title: "Financial Institution", text: transaction.institution)
            TransactionDetailRow(icon: "creditcard", title: "Account", text: transaction.account)
            
            NavigationLink {
                CategoryView(transaction: transaction)
            } label: {
                TransactionDetailRow(icon: "list", title: "Category", text: transaction.category)
            }
        }
        .listStyle(.plain)
        .navigationTitle("Transaction")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TransactionRow: View {
    var transaction: Transaction
    
    var body: some View {
        
        // Horizontal Stack for a row, duh
        HStack(spacing: 20) {
            ZStack {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: .continuous).fill(Color.gray)
                    .frame(width: 44, height: 44)
                Image(systemName: transaction.icon)
                    .foregroundColor(.white)
            }
            
            VStack { // Contains the Counteragent and Category details
                Text(transaction.merchant)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                Text(transaction.category)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(2)
                
                // Alternative: from the transaction struct 
                Text(transaction.parsedDate, format: .dateTime.day().month().year())
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
            VStack {
                Text(transaction.account)
                    .font(.subheadline)
                    .opacity(0.7)
                    .lineLimit(1)
            }
            
            Text(transaction.signedAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .bold()
                .foregroundColor(transaction.type == TransactionType.credit.rawValue ? Color.text : .primary)
        }
        .padding([.top, .bottom], 8)
    }
}


#Preview {
//    TransactionRow(transaction: transactionListPreviewData[0])
    NavigationView {
        TransactionView(transaction: transactionListPreviewData[0])
    }
}
