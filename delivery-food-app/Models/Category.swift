//
//  Category.swift
//  delivery-food-app
//
//  Created by Eugene on 17.03.23.
//

import Foundation

struct CategoriesResponse: Codable {
    let categories: [Category]
}

struct Category: Codable {
    let id: Int
    let title: String
}
