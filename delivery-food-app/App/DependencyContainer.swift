//
//  DependencyContainer.swift
//  delivery-food-app
//
//  Created by Eugene on 19.04.23.
//

import UIKit

final class DependencyContainer {
    static let shared = DependencyContainer()

    //MARK: Services
    private let cartService: CartService
    private let menuService: MenuService
    private let benefitService: BenefitsService
    private let menuArchiverService: MenuArchiver
    
    private var router: Router
    var screenFactory: ScreenFactory
    
    init() {
        cartService = CartServiceImpl()
        menuService = MenuServiceImpl()
        benefitService = BenefitsServiceImpl()
        menuArchiverService = MenuArchiverServiceImpl()
        router = RouterImpl()
        
        screenFactory = ScreenFactoryImpl()
        screenFactory.di = self
        router.di = self
    }
    
    //MARK: Providers
    var menuProvider: MenuProviderImpl {
        return MenuProviderImpl(menuService: menuService, menuArhiver: menuArchiverService, router: router)
    }
    
    var cartProvider: CartProviderImpl {
        return CartProviderImpl(cartService: cartService, menuArchiver: menuArchiverService, router: router)
    }

    var benefitsProvider: BenefitsProviderImpl {
        return BenefitsProviderImpl(benefitsService: benefitService, router: router)
    }
    
    var searchProductsProvider: SearchProductsProvider {
        return SearchProductsProviderImpl(router: router)
    }
}

extension DependencyContainer {
    func makeWindowWithController(scene: UIWindowScene) -> UIWindow {
        let window = UIWindow(windowScene: scene)
        
        let rootViewController = screenFactory.createTabBar()
        window.rootViewController = rootViewController
        
        return window
    }
}
