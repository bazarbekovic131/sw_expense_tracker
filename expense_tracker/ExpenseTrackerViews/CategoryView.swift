//
//  CategoryView.swift
//  week_1_program
//
//  Created by Akha on 20.07.2024.
//

import SwiftUI

struct CategoryView: View {
    var transaction: Transaction
    
    var body: some View {
        Text("Hello, World!")
        List {
            ForEach(Category.categories, id: \.id) {
                category in Section {
                    ForEach(category.subcategories ?? []) { subcategory in
                        let isSelected = transaction.categoryId == subcategory.id
                        
                        CategoryRow(category: subcategory, isSelected: isSelected)
                    }
                } header: {
                    //MARK: Categories
                    let isSelected = (transaction.categoryId == category.id)
                    
                    CategoryRow(category: category, isSelected: isSelected)
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Category")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CategoryRow: View {
    var category: Category
    var isSelected: Bool
    
    var isMain: Bool {
        category.mainCategoryId == nil
    }
    
    var body: some View {
        Text("Hello")
        HStack {
            // MARK: icon
            VStack {
                RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                    .fill(Color.icon.opacity(0.3))
                    .frame(width: isMain ? 44 : 32, height: isMain ? 44 : 32)
                    .overlay {
                        Image(systemName: category.icon)
                            .foregroundColor(.white)
                    }
            }
            .frame(width: 50)
            if isMain {
                Text(category.title)
                    .foregroundColor(.primary)
            } else {
                Text(category.title)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 16))
                    .foregroundColor(Color.icon)
            }
        }
        .contentShape(Rectangle())
    }
}

//#Preview {
//    CategoryView()
//}
