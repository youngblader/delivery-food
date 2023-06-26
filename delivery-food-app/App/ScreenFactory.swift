//
//  ScreenFactory.swift
//  delivery-food-app
//
//  Created by Eugene on 19.04.23.
//

import UIKit

protocol ScreenFactory {
    var di: DependencyContainer! { get set }
    
    func createTabBar() -> TabBarController
    func createMenuVC() -> MenuViewController
    func createCartVC() -> CartViewController
    func createBenefitsVC() -> BenefitsViewController
    func createDetailBenefitVC(_ benefit: Benefit) -> DetailBenefitViewController
    func createDetailProductVC(_ product: Product) -> DetailProductViewController
    func createSearchProductsVC(_ products: [Product]) -> UINavigationController
}

final class ScreenFactoryImpl: ScreenFactory {
    weak var di: DependencyContainer!
    
    func createTabBar() -> TabBarController {
        return TabBarController()
    }
    
    func createMenuVC() -> MenuViewController {
        return MenuViewController(provider: di.menuProvider)
    }
    
    func createCartVC() -> CartViewController {
        return CartViewController(provider: di.cartProvider)
    }
    
    func createDetailBenefitVC(_ benefit: Benefit) -> DetailBenefitViewController {
        return DetailBenefitViewController(provider: di.benefitsProvider, selectedBenefit: benefit)
    }

    func createBenefitsVC() -> BenefitsViewController {
        return BenefitsViewController(provider: di.benefitsProvider)
    }
    
    func createDetailProductVC(_ product: Product) -> DetailProductViewController {
        return DetailProductViewController(provider: di.menuProvider, product: product)
    }

    func createSearchProductsVC(_ products: [Product]) -> UINavigationController {
        let controller = SearchProductsViewController(provider: di.searchProductsProvider, products: products)
        return UINavigationController(rootViewController: controller)
    }
}
