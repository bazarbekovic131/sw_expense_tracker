//
//  RecentTransactionsView.swift
//  week_1_program
//
//  Created by Akha on 11.05.2024.
//

import SwiftUI

struct RecentTransactionsView: View {
    
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    var body: some View {
        
        VStack {
            HStack {
                Text("Recent Transactions")
                    .bold()
                Spacer()
                NavigationLink {
                    TransactionList()
                } label: {
                    HStack(spacing: 4) {
                        Text("See all")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(Color.blue)
                }
            }
            .padding(.top)
            
            // MARK: Recent ones
            ForEach(Array(transactionListVM.transactions.prefix(5).enumerated()), id: \.element) {
                index, transaction in 
                
                NavigationLink {
                    TransactionView(transaction: transaction)
                } label: {
                    TransactionRow(transaction: transaction)
                }
                
                
                Divider()
                    .opacity(index == 4 ? 0:1)
            }
            
        }.padding()
            .background(Color.systemBackground)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color.primary.opacity(0.2), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 5)
    }
}

let transactionListVM: TransactionListViewModel = {
    let transactionListVM = TransactionListViewModel()
    transactionListVM.transactions = transactionListPreviewData
    return transactionListVM
}()
#Preview {
    NavigationView {
        RecentTransactionsView()
    }
    .environmentObject(transactionListVM)
}
