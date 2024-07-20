//
//  TransactionList.swift
//  week_1_program
//
//  Created by Akha on 11.05.2024.
//

import SwiftUI

struct TransactionList: View {
    var body: some View {
        VStack {
            List {
                ForEach(Array(transactionListVM.groupTransactionsByMonth()), id: \.key) {
                    month, transactions in
                    Section {
                        ForEach(transactions) { transaction in
                            NavigationLink {
                                TransactionView(transaction: transaction)
                            } label: {
                                TransactionRow(transaction: transaction)
                            }
                        }
                    } header: {
                        Text(month)
                    }
                }
            }.listStyle(.grouped)
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        TransactionList()
            .environmentObject(transactionListVM)
    }
}
