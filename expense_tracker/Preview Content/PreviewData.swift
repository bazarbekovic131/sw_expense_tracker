//
//  PreviewData.swift
//  week_1_program
//
//  Created by Akha on 09.05.2024.
//

import Foundation

var transactionPreviewData = Transaction(id: 1, date: "01/24/2022", institution: "Desjardins", account: "Visa Desjardins", merchant: "Apple", categoryId: 801, category: "Software", amount: 11.49, type: "debit", isTransfer: false, isPending: false, isExpense: true, isEdited: false)

var transactionListPreviewData = [Transaction](repeating: transactionPreviewData, count: 10)
