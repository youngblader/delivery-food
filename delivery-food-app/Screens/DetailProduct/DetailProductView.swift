//
//  DetailProductView.swift
//  delivery-food-app
//
//  Created by Eugene on 12.03.23.
//

import UIKit
import SnapKit

final class DetailProductView: UIView {
    var detailProductTableView = DetailProductTableView()
    var nutrientsProductView = NutrientsProductView()
    private var detailAddProductView = DetailAddProductView()
    private lazy var closeButton = CloseButton()
    
    var onDismissController: (()->())?
    var onUpdateProducts: (([Product])->())?
    var onPresentNutrientsProductView: (()->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
        
        detailAddProductView.onDismiss = {
            self.dismiss()
        }
        
        detailAddProductView.onUpdateProducts = { products in
            self.onUpdateProducts?(products)
        }
        
        detailProductTableView.onAboutButtonTapped = {
            self.onPresentNutrientsProductView?()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public update
    func update(_ product: Product, _ archiveProducts: [Product]) {
        detailProductTableView.update(product)
        detailAddProductView.update(product, archiveProducts)
        nutrientsProductView.update(product)
    }
    
    @objc private func dismiss() {
        onDismissController?()
    }
}

extension DetailProductView {
    private func setupViews() {
        self.backgroundColor = .white
        
        self.addSubview(detailProductTableView)
        self.addSubview(detailAddProductView)
        self.addSubview(closeButton)
        
        self.addSubview(nutrientsProductView)
        
        closeButton.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        detailProductTableView.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.left.right.equalTo(self)
            make.bottom.equalTo(detailAddProductView.snp.top)
        }
        
        detailAddProductView.snp.makeConstraints { make in
            make.left.right.equalTo(self)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.right.equalTo(self).inset(16)
        }
        
        nutrientsProductView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self)
        }
    }
}
