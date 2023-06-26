//
//  OrderDetailCell.swift
//  delivery-food-app
//
//  Created by Eugene on 28.02.23.
//

import UIKit
import SnapKit

final class OrderDetailCell: UITableViewCell {
    static let reuseId = "OrderDetailCell"
    
    private lazy var countLabel = TextLabel(size: 14, weight: .medium)
    private lazy var priceLabel = TextLabel(size: 14, weight: .medium)
    
    private let titleCoinsLabel = TextLabel(label: "Начислим коинов", size: 14, weight: .medium)
    private let coinsLabel = TextLabel(label: "+103", size: 14, color: .grayOrange,  weight: .medium)
    
    private let deliveryLabel = TextLabel(label: "Доставка", size: 14, weight: .medium)
    private let deliveryTypeLabel = TextLabel(label: "Бесплатно", size: 14, weight: .medium)
    
    private let containerStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 20
        
        return stack
    }()
    
    private func horizontalStack() -> UIStackView {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        
        return stack
    }
    
    private var promoButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Ввести промокод", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(UIColor.grayOrange, for: .normal)
        
        button.backgroundColor = UIColor.lightOrange
        button.layer.cornerRadius = 20
        
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public update
    func update(_ order: Order) {
        countLabel.text = "\(order.count) товара"
        priceLabel.text = "\(order.totalPrice) ₽"
    }
}

extension OrderDetailCell {
    private func setupViews() {
        let productsCountStack = horizontalStack()
        let coinsStack = horizontalStack()
        let deliveryStack = horizontalStack()
        
        contentView.addSubview(containerStack)
        
        containerStack.addArrangedSubview(promoButton)
        containerStack.addArrangedSubview(productsCountStack)
        containerStack.addArrangedSubview(coinsStack)
        containerStack.addArrangedSubview(deliveryStack)
        
        productsCountStack.addArrangedSubview(countLabel)
        productsCountStack.addArrangedSubview(priceLabel)
        
        coinsStack.addArrangedSubview(titleCoinsLabel)
        coinsStack.addArrangedSubview(coinsLabel)
        
        deliveryStack.addArrangedSubview(deliveryLabel)
        deliveryStack.addArrangedSubview(deliveryTypeLabel)
    }
    
    private func setupConstraints() {
        containerStack.snp.makeConstraints { make in
            make.top.left.right.equalTo(contentView).inset(20)
            make.bottom.equalTo(contentView).inset(10)
        }
    }
}
