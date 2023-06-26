//
//  DetailProductPriceView.swift
//  delivery-food-app
//
//  Created by Eugene on 18.03.23.
//

import UIKit
import SnapKit

final class DetailAddProductView: UIView {
    private let notificationCenter = NotificationCenter.default
    
    private var selectProduct: Product?
    private var archiveProducts: [Product] = []
    
    var onDismiss: (()->())?
    var onUpdateProducts: (([Product])->())?

    private let separatorView = SeparatorView()
    
    private lazy var orderButton: UIButton = {
        var button = UIButton(type: .system)
        
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.white, for: .normal)

        button.layer.cornerRadius = 20
        button.backgroundColor = .orange
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        button.addTarget(self, action: #selector(addProductToCart(sender:)), for: .touchUpInside)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public update
    func update(_ product: Product, _ products: [Product]) {
        self.selectProduct = product
        self.archiveProducts = products

        orderButton.setTitle("В корзину за \(product.price) ₽", for: .normal)
    }
    
    private func isDuplicateProduct() -> Bool {
        return archiveProducts.contains { $0.id == selectProduct?.id }
    }
    
    private func getProductCount() -> Int {
        return archiveProducts.reduce(0) { acc, curr in
            acc + (curr.count ?? 1)
        }
    }
    
    //MARK: Action
    @objc private func addProductToCart(sender: UIButton) {
        sender.showAnimation { [self] in
            let isRepeatProduct = isDuplicateProduct()
            
            defer {
                onUpdateProducts?(archiveProducts)
                
                notificationCenter.post(name: Notification.Name("UpdateBadgeValue"), object: nil, userInfo: ["count": getProductCount()])
                
                onDismiss?()
            }
            
            if archiveProducts.isEmpty || !isRepeatProduct {
                archiveProducts.append(selectProduct!)
                
                return
            }
            
            for item in archiveProducts {
                var count = item.count ?? 1
                
                if item.id == selectProduct?.id {
                    count += 1
                    item.count = count
                }
            }
        }
    }
}

extension DetailAddProductView {
    private func setupViews() {
        self.backgroundColor = .white.withAlphaComponent(0.7)

        self.addSubview(separatorView)
        self.addSubview(orderButton)
    }
    
    private func setupConstraints() {
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.left.right.equalTo(self)
        }
        
        orderButton.snp.makeConstraints { make in
            make.top.left.right.equalTo(self).inset(20)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
