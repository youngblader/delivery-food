//
//  CartService.swift
//  delivery-food-app
//
//  Created by Eugene on 28.02.23.
//

import Foundation

final class Order {
    var products: [Product]
    
    var totalPrice: Int {
        return products.reduce(0) { acc, curr in
            let modificatorsPrice = curr.modificators?.modificatorsToAdd?.reduce(0, { result, curr in
                result + curr.price
            }) ?? 0

            return acc + (curr.count ?? 1) * (curr.price + modificatorsPrice)
        }
    }
    
    var count: Int {
        return products.reduce(0) { acc, curr in
            acc + (curr.count ?? 1)
        }
    }
    
    init(products: [Product]) {
        self.products = products
    }
}

protocol CartService {
    var order: Order { get set }
}

final class CartServiceImpl: CartService {
    var order = Order(products: [])
}
