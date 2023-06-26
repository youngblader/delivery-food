//
//  PriceHeaderView.swift
//  delivery-food-app
//
//  Created by Eugene on 28.02.23.
//

import UIKit
import SnapKit

final class PriceHeaderView: UIView {    
    lazy private var priceLabel = TextLabel(size: 20, weight: .bold)
    
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
    func update(_ count: Int, _ price: Int) {
        priceLabel.text = "\(count) товаров на сумму \(price) ₽"
    }
}

extension PriceHeaderView {
    private func setup() {
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60)
    }
    
    private func setupViews() {
        self.addSubview(priceLabel)
    }
    
    private func setupConstraints() {
        priceLabel.snp.makeConstraints { make in
            make.edges.equalTo(self).inset(20)
        }
    }
}
