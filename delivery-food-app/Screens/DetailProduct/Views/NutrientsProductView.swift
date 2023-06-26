//
//  NutrientsProductView.swift
//  delivery-food-app
//
//  Created by Eugene on 18.05.23.
//

import UIKit
import SnapKit

final class NutrientsProductView: UIView {
    private var selectProduct: Product?
    private var nutrientsTableView = NutrientsTableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public update
    func update(_ product: Product) {
        nutrientsTableView.update(product)
    }
}

extension NutrientsProductView {
    private func setup() {
        self.alpha = 0.0
        self.layer.cornerRadius = 12
        self.backgroundColor = UIColor.backgroundBlack
        
        self.widthAnchor.constraint(equalToConstant: 300).isActive = true
        self.heightAnchor.constraint(equalToConstant: 230).isActive = true
    }
    
    private func setupViews() {
        self.addSubview(nutrientsTableView)
    }
    
    private func setupConstraints() {
        nutrientsTableView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
}
