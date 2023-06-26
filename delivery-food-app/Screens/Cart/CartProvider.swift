//
//  CartProvider.swift
//  delivery-food-app
//
//  Created by Eugene on 19.04.23.
//

import Foundation

protocol CartProvider {
    var cartService: CartService { get }
    var menuArchiver: MenuArchiver { get }
    var router: Router { get }
}

final class CartProviderImpl: CartProvider {
    let cartService: CartService
    let menuArchiver: MenuArchiver
    let router: Router
    
    //MARK: Dependencies
    init(cartService: CartService, menuArchiver: MenuArchiver, router: Router) {
        self.cartService = cartService
        self.menuArchiver = menuArchiver
        self.router = router
    }
}
