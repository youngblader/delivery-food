//
//  SearchProductsProvider.swift
//  delivery-food-app
//
//  Created by Eugene on 5.06.23.
//

import Foundation

protocol SearchProductsProvider {
    var router: Router { get }
}

final class SearchProductsProviderImpl: SearchProductsProvider {
    var router: Router
    
    //MARK: Dependencies
    init(router: Router) {
        self.router = router
    }
}
