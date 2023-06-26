//
//  CartTableView.swift
//  delivery-food-app
//
//  Created by Eugene on 9.03.23.
//

import UIKit
import SnapKit

private enum CartSection: Int, CaseIterable {
    case product = 0
    case detailOrder = 1
}

final class CartTableView: UITableView {
    private let notificationCenter = NotificationCenter.default
    
    var order: Order = Order(products: [])
    
    var onProductsIsEmpty: (()->())?
    var onUpdatePriceFooterView: (()->())?
    var onUpdateProducts: (([Product])->())?
    
    lazy var priceHeaderView = PriceHeaderView()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: .zero, style: .plain)
        
        self.tableHeaderView = priceHeaderView
        
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
        
        self.allowsSelection = false
        
        self.delegate = self
        self.dataSource = self

        self.register(ProductCell.self, forCellReuseIdentifier: ProductCell.reuseId)
        self.register(OrderDetailCell.self, forCellReuseIdentifier: OrderDetailCell.reuseId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public update
    func update(_ order: Order) {
        self.order = order
        priceHeaderView.update(order.count, order.totalPrice)
    }
    
    private func updateDataTableView() {
        priceHeaderView.update(order.count, order.totalPrice)
        onUpdatePriceFooterView?()
        
        self.reloadData()
    }
    
    //MARK: - Actions
    @objc private func productCountChanged(counter: CounterView) {
        order.products[counter.index].count = counter.countValue
        
        if counter.countValue == 0 {
            order.products.remove(at: counter.index)
            onProductsIsEmpty?()
        }
        
        updateDataTableView()
        onUpdateProducts?(order.products)
        
        notificationCenter.post(name: Notification.Name("UpdateBadgeValue"), object: nil, userInfo: ["count" : order.count])
    }
}

extension CartTableView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return CartSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = CartSection(rawValue: section)
        
        switch (section) {
        case .product:
            return order.products.count
        case .detailOrder:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = CartSection(rawValue: indexPath.section)
        
        switch (section) {
        case .product:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.reuseId, for: indexPath) as! ProductCell
            
            let product = order.products[indexPath.row]
            cell.update(product, indexPath.row)
            
            cell.counterView.addTarget(self, action: #selector(productCountChanged(counter:)), for: .valueChanged)
            
            return cell
        case .detailOrder:
            let cell = tableView.dequeueReusableCell(withIdentifier: OrderDetailCell.reuseId, for: indexPath) as! OrderDetailCell
            
            cell.update(order)
            
            // removed separator in cell
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            cell.directionalLayoutMargins = .zero
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}
