//
//  CartView.swift
//  delivery-food-app
//
//  Created by Eugene on 9.03.23.
//

import UIKit
import SnapKit

final class CartView: UIView {
    private var order: Order = Order(products: [])

    private var cartTableView = CartTableView()
    private var priceFooterView = PriceFooterView()
    var emptyCartView = EmptyCartView()

    var onAcceptOrderTapped: (()->())?
    var onUpdateProducts: (([Product])->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setupConstraints()
        
        cartTableView.onProductsIsEmpty = {
            self.hiddenViews()
            self.update(self.order)
        }
        
        cartTableView.onUpdatePriceFooterView = {
            self.priceFooterView.update(self.order.totalPrice)
        }
        
        cartTableView.onUpdateProducts = { products in
            self.onUpdateProducts?(products)
        }
        
        priceFooterView.onAcceptOrderTapped = {
            self.onAcceptOrderTapped?()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public update
    func update(_ order: Order) {
        self.order = order

        cartTableView.update(order)
        priceFooterView.update(order.totalPrice)
        cartTableView.reloadData()

        hiddenViews()
    }
    
    private func hiddenViews() {
        if order.products.isEmpty {
            cartTableView.isHidden = true
            priceFooterView.isHidden = true
            emptyCartView.isHidden = false
        } else {
            emptyCartView.isHidden = true
            cartTableView.isHidden = false
            priceFooterView.isHidden = false
        }
    }
}

extension CartView {
    private func setupViews() {
        self.backgroundColor = .white

        self.addSubview(cartTableView)
        self.addSubview(emptyCartView)
        self.addSubview(priceFooterView)
    }
    
    private func setupConstraints() {
        cartTableView.snp.makeConstraints { make in
            make.top.left.right.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(priceFooterView.snp.top)
        }
        
        priceFooterView.snp.makeConstraints { make in
            make.left.right.equalTo(self)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }

        emptyCartView.snp.makeConstraints { make in
            make.top.left.right.equalTo(self.safeAreaLayoutGuide)
            make.centerX.centerY.equalTo(self)
        }
    }
}
