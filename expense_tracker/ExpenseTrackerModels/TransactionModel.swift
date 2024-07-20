//
//  TransactionModel.swift
//  week_1_program
//
//  Created by Akha on 09.05.2024.
//

import Foundation

struct Transaction: Identifiable, Decodable, Hashable {
    let id: Int32 // link/ ssylka na dokument
    var date: String // convert to Date?
    var institution: String // I don't know
    var account: String // accound name, can be a link to the account
    var merchant: String // counteragent?
    var categoryId: Int
    var category: String
    var amount: Double
    var parsedDate: Date {
        getDate(dateformat: "dd-MM-yyyy") ?? Date()
    }
    
    var signedAmount: Double {
        return type == TransactionType.credit.rawValue ? amount: -amount
    }
    
    let type: TransactionType.RawValue // struct in TransactionModel.swift, row xx
//    var dateformat: DatumFormat = .dayMonthYear
    var icon: String {
        if let category = Category.categories.first(where: {$0.id == categoryId}) {
            
            return category.icon
        }
        
        return "house"
    }
    var month: String {
        parsedDate.formatted(.dateTime.year().month(.wide))
    }
    
    // boolean states
    var isTransfer: Bool
    var isPending: Bool
    var isExpense: Bool
    var isEdited: Bool
    
}


enum TransactionType:String {
    case debit = "debit"
    case credit = "credit"
}

struct Category:Identifiable {
    let id: Int
    let title: String
    let icon: String
    var mainCategoryId: Int?
    
    var subcategories: [Category]? {
        Category.subCategories.filter {
            $0.mainCategoryId == id
        }
    }
}

extension Category {
    static let work = Category(id: 801, title: "Beschäftigung", icon: "suitcase")
    static let sideHustle = Category(id: 102, title: "Nebengewerbe", icon: "tengesign.arrow.circlepath")
    static let stipendium = Category(id: 502, title: "Stipendium", icon: "building.columns")
    static let transfers = Category(id: 701, title: "Überweisungen", icon: "dollarsign.circle")
    static let investments = Category(id: 402, title: "Investitionen", icon: "creditcard.circle")
    static let food = Category(id: 102, title: "Essen", icon: "carrot")
    static let transport = Category(id: 7, title: "Transport", icon: "bus")
    static let communications = Category(id: 8, title: "", icon: "network")
    static let appleServices = Category(id: 9, title: "", icon: "apple.logo")
    static let streamingServices = Category(id: 10, title: "", icon: "film")
    static let games = Category(id: 11, title: "", icon: "gamecontroller")
    static let zusatzServices = Category(id: 12, title: "", icon: "link.badge.plus")
    static let healthAndFitness = Category(id: 13, title: "", icon: "heart")
    static let hobbys = Category(id: 14, title: "", icon: "tennis.racket")
    static let clothes = Category(id: 15, title: "", icon: "tshirt")
    static let freizeitAndCulture = Category(id: 16, title: "", icon: "tree")
    static let education = Category(id: 17, title: "", icon: "book")
    static let personalCare = Category(id: 18, title: "", icon: "fleuron")
    static let geschenke = Category(id: 19, title: "", icon: "gift")
    static let techs = Category(id: 20, title: "", icon: "laptopcomputer")
    static let shopping = Category(id: 21, title: "Einkäufe", icon: "cart")
    static let onlineSelling = Category(id: 10202, title: "Online-Verkauf", icon: "cart", mainCategoryId: 102)
    static let advisory = Category(id: 10203, title: "Beratung", icon: "bubble.left", mainCategoryId: 102)
    static let categories: [Category] = [
        .work,
        .sideHustle,
        .stipendium,
        .transfers,
        .investments,
        .food,
        .transport,
        .appleServices,
        .clothes,
        .communications,
        .education,
        .streamingServices,
        .games,
        .geschenke,
        .zusatzServices,
        .healthAndFitness,
        .hobbys,
        .freizeitAndCulture,
        .personalCare,
        .techs,
        .shopping
    ]
    
    static let subCategories: [Category] = [
        .onlineSelling,
        .advisory
    ]
}

enum DatumFormat: String {
    case yearMonthDay = "yyyy-MM-dd"
    case dayMonthYear = "dd-MM-yyyy"
    
    // MARK: needs to be extended in future
}

