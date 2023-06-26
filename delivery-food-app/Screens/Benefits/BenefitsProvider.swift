//
//  BenefitsProvider.swift
//  delivery-food-app
//
//  Created by Eugene on 19.04.23.
//

import Foundation

protocol BenefitsProvider {
    var benefitsService: BenefitsService { get }
    var router: Router { get }
}

final class BenefitsProviderImpl: BenefitsProvider {
    let benefitsService: BenefitsService
    let router: Router
    
    //MARK: Dependencies
    init(benefitsService: BenefitsService, router: Router) {
        self.benefitsService = benefitsService
        self.router = router
    }
}
