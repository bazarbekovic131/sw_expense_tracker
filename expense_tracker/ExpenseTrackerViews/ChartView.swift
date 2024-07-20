//
//  ChartView.swift
//  week_1_program
//
//  Created by Akha on 12.05.2024.
//

import SwiftUI
import SwiftUICharts
import Foundation

struct ChartView: View {
    var chartData: TransactionPrefixSum
    var body: some View {
        let totalExpenses = chartData.last?.1 ?? 999
        let identifier = Locale.current.currency?.identifier ?? "USD"
        let symbol = Locale.current.currencySymbol ?? "$"
        CardView {
            VStack(alignment: .leading) {
                
                ChartLabel(totalExpenses.formatted(.currency(code: identifier)), type: .title, format: "\(symbol)%.02f")
                LineChart()
            }
            .background(Color.systemBackground)
        }
        .data(chartData)
        .chartStyle(ChartStyle(backgroundColor: Color.systemBackground, foregroundColor: ColorGradient(Color.icon.opacity(0.4), Color.icon)))
        .frame(height: 300)
        
    }
}

//#Preview {
//    ChartView(chartData: data)
//}
