//
//  MenuProvider.swift
//  delivery-food-app
//
//  Created by Eugene on 19.04.23.
//

import Foundation

protocol MenuProvider {
    var menuService: MenuService { get set }
    var menuArhiver: MenuArchiver { get set }
    var router: Router { get }
}

final class MenuProviderImpl: MenuProvider {
    var menuService: MenuService
    var menuArhiver: MenuArchiver
    var router: Router
    
    //MARK: Dependencies
    init(menuService: MenuService, menuArhiver: MenuArchiver, router: Router) {
        self.menuService = menuService
        self.menuArhiver = menuArhiver
        self.router = router
    }
}
