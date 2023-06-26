//
//  Product.swift
//  delivery-food-app
//
//  Created by Eugene on 12.03.23.
//

import Foundation

struct Modificator: Codable {
    let id, price: Int
    let name, image: String
}

struct Modificators: Codable {
    var modificatorsToAdd: [Modificator]?
    var modificatorsAvailableToAdd: [Modificator]?
}

struct Nutrient: Codable {
    var name: String
    var value: String
}

final class Product: Codable {
    var id, price: Int
    var name, image: String
    var description, size, weight: String?
    var count: Int?
    var modificators: Modificators?
    var nutrients: [Nutrient]?
 
    init(id: Int, name: String, description: String? = nil, size: String? = nil, price: Int, count: Int = 1, image: String, weight: String? = nil, modificators: Modificators, nutrients: [Nutrient]) {
        self.id = id
        self.name = name
        self.description = description
        self.size = size
        self.count = count
        self.price = price
        self.image = image
        self.weight = weight
        self.modificators = modificators
        self.nutrients = nutrients
    }
}
