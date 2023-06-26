//
//  SearchProductsViewController.swift
//  delivery-food-app
//
//  Created by Eugene on 30.05.23.
//

import UIKit
import SnapKit

final class SearchProductsViewController: UIViewController {
    private var searchProductsProvider: SearchProductsProvider
    
    private var products: [Product] = []
    private var filtredProducts: [Product] = []

    // searchController properties
    private var searchBarIsEmpty: Bool {
        guard let text = searchProductsView.searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchProductsView.searchController.isActive && !searchBarIsEmpty
    }
    
    // LoadView
    private var searchProductsView: SearchProductsView {
        return self.view as! SearchProductsView
    }
    
    override func loadView() {
        self.view = SearchProductsView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        searchProductsView.searchController.update(getRandomProductName())
        
        searchProductsView.searchResultsTableView.onSelectProductTapped = { product in
            self.presentDetailProduct(product)
        }
        
        searchProductsView.searchController.onFilterSearchProducts = { searchText in
            self.filterProductsBySearchText(searchText)
        }
        
        searchProductsView.searchController.onDismissTapped = {
            self.dismiss()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        searchProductsView.searchController.isActive = true
    }
    
    init(provider: SearchProductsProvider, products: [Product]) {
        self.searchProductsProvider = provider
        self.products = products

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func filterProductsBySearchText(_ searchText: String) {
        self.filtredProducts = self.products.filter({ product in
            return product.name.lowercased().uppercased().prefix(searchText.count) == searchText.lowercased().uppercased()
        })
        
        searchProductsView.update(filtredProducts, isFiltering)
    }
    
    private func getRandomProductName() -> String {
        guard let product = products.randomElement() else { return "" }

        return product.name
    }
    
    private func presentDetailProduct(_ product: Product) {
        searchProductsProvider.router.navigateToDetailProduct(product, self)
    }
    
    @objc private func dismiss() {
        searchProductsProvider.router.dismiss(self)
    }
}

extension SearchProductsViewController {
    private func setup() {
        self.definesPresentationContext = true
        self.navigationItem.titleView = searchProductsView.searchController.searchBar
    }
}
