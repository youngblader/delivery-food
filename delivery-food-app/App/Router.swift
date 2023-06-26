//
//  Router.swift
//  delivery-food-app
//
//  Created by Eugene on 15.05.23.
//

import UIKit

protocol Router {
    var di: DependencyContainer! { get set }
    
    func navigateToDetailProduct(_ product: Product, _ from: UIViewController)
    func navigateToDetailBenefit(_ benefit: Benefit, _ from: UIViewController)
    func navigateToSearchProducts(_ products: [Product], _ from: UIViewController)
    func dismiss(_ from: UIViewController)
}

final class RouterImpl: Router {
    weak var di: DependencyContainer!
    
    func navigateToDetailProduct(_ product: Product, _ from: UIViewController) {
        let controller = di.screenFactory.createDetailProductVC(product)
        
        from.present(controller, animated: true)
    }
    
    func navigateToDetailBenefit(_ benefit: Benefit, _ from: UIViewController) {
        let controller = di.screenFactory.createDetailBenefitVC(benefit)
        
        from.present(controller, animated: true)
    }
    
    func navigateToSearchProducts(_ products: [Product], _ from: UIViewController) {
        let controller = di.screenFactory.createSearchProductsVC(products)
        controller.modalPresentationStyle = .custom
        
        from.present(controller, animated: true)
    }
    
    func dismiss(_ from: UIViewController) {
        from.dismiss(animated: true, completion: nil)
    }
}
