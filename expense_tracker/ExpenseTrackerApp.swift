//
//  week_1_programApp.swift
//  week_1_program
//
//  Created by Akha on 09.05.2024.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    
    // State ensures that it follows the lifecycle of the app
    @StateObject var transactionListVM = TransactionListViewModel() // from the ExpenseTrackerModel
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}
