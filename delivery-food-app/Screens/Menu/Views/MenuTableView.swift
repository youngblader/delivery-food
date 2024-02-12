//
//  MenuTableView.swift
//  delivery-food-app
//
//  Created by Eugene on 10.03.23.
//

import UIKit
import SnapKit

final class MenuTableView: UITableView {
    private var menuProducts: [Menu] = []
    private var categories: [Category] = []

    private var menuHeaderView = MenuHeaderView()
    var categoryCollectionView = CategoryCollectionView()
    
    var onSelectedProduct: ((Product)->())?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: .zero, style: style)
        
        self.tableHeaderView = menuHeaderView
        
        self.delegate = self
        self.dataSource = self
        self.allowsSelection = false
        
        self.separatorStyle = .none
        
        self.register(MenuCell.self, forCellReuseIdentifier: MenuCell.reuseId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: Public update
    func update(_ data: MenuData) {
        self.menuProducts = data.menu
        self.categories = data.categories
        
        self.reloadData()
    }
    
    private func filtredProductsByCategory(_ id: Int) -> [Product] {
        return menuProducts.first(where: { $0.categoryId == id })?.products ?? []
    }

    private func scrollToCategory() {
        categoryCollectionView.onCategoryTapped = { index in
            self.scrollToRow(at: [0, index], at: .middle, animated: true)
        }
    }
} 

extension MenuTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: MenuCell.reuseId, for: indexPath) as! MenuCell
        
        let category = categories[indexPath.row]
        let products = filtredProductsByCategory(category.id)

        cell.update(category, products)
        
        cell.onSelectedProduct = { product in
            self.onSelectedProduct?(product)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        scrollToCategory()
        categoryCollectionView.update(categories)
        
        return categoryCollectionView
    }
}
