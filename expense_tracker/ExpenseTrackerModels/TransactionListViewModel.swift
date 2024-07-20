//
//  TransactionListViewModel.swift
//  week_1_program
//
//  Created by Akha on 11.05.2024.
//

import Foundation
import Combine
import Collections
// Observable Object is a part of Combine framework that turns any object into a publisher and will notify its subs of its state changes, so they can refresh their views.

typealias TransactionGroup =  OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(String, Double)]

final class TransactionListViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getTransactions()
    }
    
    func getTransactions() {
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let HttpResponse = response as? HTTPURLResponse, HttpResponse.statusCode == 200 else {
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching transactions:", error.localizedDescription)
                case .finished:
                    print("Finished")
                }
            
            } receiveValue: { [weak self] result in
                self?.transactions = result
                dump(self?.transactions)
            }
            .store(in: &cancellables)

    }
    
    func groupTransactionsByMonth() -> TransactionGroup {
        guard !transactions.isEmpty else {
            return [:]
        }
        let sortedTransactions = TransactionGroup(grouping: transactions) { $0.month }
        
        return sortedTransactions
    }
    
    func accumulateTransactions() -> TransactionPrefixSum {
        guard !transactions.isEmpty else {
            return []
        }
        var today = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        today = dateFormatter.date(from: "17-02-2022")!
        
        let dateInterval = Calendar.current.dateInterval(of: .year, for: today)
        print("dateInterval", dateInterval)
        
        var sum: Double = .zero
        var cumulativeSum = TransactionPrefixSum()
        
        for date in stride(from: dateInterval!.start, to: today, by: 60*60*24) {
            let dailyExpenses = transactions.filter({ $0.isExpense && $0.parsedDate == date})
            let dailyTotal = dailyExpenses.reduce(0) { $0 - $1.signedAmount }
            
            sum += dailyTotal
            cumulativeSum.append((date.formatted(), sum))
            print(date.formatted(), "DailyTotal", dailyTotal, "sum: ", sum)
        }
        
        return cumulativeSum
    }
}
