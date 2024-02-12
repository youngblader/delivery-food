//
//  Menu.swift
//  delivery-food-app
//
//  Created by Eugene on 22.03.23.
//

import Foundation

struct MenuResponse: Codable {
    let menu: [Menu]
}

struct Menu: Codable {
    let categoryId: Int
    let products: [Product]
}

typealias MenuData = (categories: [Category], menu: [Menu])
