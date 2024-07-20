//
//  ContentView.swift
//  week_1_program
//
//  Created by Akha on 09.05.2024.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Overview") // MARK: title
                        .font(.title)
                        .bold()
                    
                    let data = transactionListVM.accumulateTransactions()
                    
                    if !data.isEmpty {
                        ChartView(chartData: data)
                    }
                }.padding().frame(maxWidth: .infinity)
                
                Spacer()
                
                RecentTransactionsView()
                
            }
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Note: Notification Item
                ToolbarItem {
                    Image(systemName: "bell.badge")
                        .symbolRenderingMode(.palette)
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    ContentView().environmentObject(transactionListVM)
}
