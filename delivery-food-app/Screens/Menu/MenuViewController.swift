//
//  MenuViewController.swift
//  delivery-food-app
//
//  Created by Eugene on 28.02.23.
//

import UIKit
import SnapKit

final class MenuViewController: UIViewController {
    private let notificationCenter = NotificationCenter.default
    private let menuProvider: MenuProvider
    
    private var products: [Product] = []
    
    private lazy var searchButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(presentSearchProductsScreen))
        
        button.tintColor = UIColor.black
        
        return button
    }()
    
    private var menuView: MenuView {
        return self.view as! MenuView
    }
    
    override func loadView() {
        self.view = MenuView(frame: UIScreen.main.bounds)
    }
    
    init(provider: MenuProvider) {
        self.menuProvider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        fetchData()
        updateCartBadge()
        
        menuView.menuTableView.onSelectedProduct = { product in
            self.presentDetailProductScreen(product)
        }
    }
    
    private func fetchData() {
        Task {
            do {
                async let categoriesRequest = menuProvider.menuService.fetchCategories()
                async let menuRequest = menuProvider.menuService.fetchMenu()
                
                let data: MenuData = try await (categoriesRequest, menuRequest)
                
                menuView.update(data)
                self.products = modifiedMenuData(data.menu)
            } catch {
                print(error)
            }
        }
    }
    
    private func modifiedMenuData(_ array: [Menu]) -> [Product] {
        var products: [Product] = []
        
        for item in array {
            products += item.products
        }
        
        return products
    }
    
    private func updateCartBadge() {
        let order = Order(products: menuProvider.menuArhiver.retrieve())
        
        notificationCenter.post(name: Notification.Name("UpdateBadgeValue"), object: nil, userInfo: ["count": order.count])
    }
    
    private func presentDetailProductScreen(_ product: Product) {
        menuProvider.router.navigateToDetailProduct(product, self)
    }
    
    @objc func presentSearchProductsScreen() {
        menuProvider.router.navigateToSearchProducts(products, self)
    }
}

extension MenuViewController {
    private func setup() {
        self.title = "Меню"
        self.navigationItem.rightBarButtonItem = searchButton
    }
}
