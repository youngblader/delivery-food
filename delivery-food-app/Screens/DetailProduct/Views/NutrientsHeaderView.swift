//
//  NutrientsHeaderView.swift
//  delivery-food-app
//
//  Created by Eugene on 23.05.23.
//

import UIKit
import SnapKit

final class NutrientsHeaderView: UIView {
    private let nameLabel = TextLabel(size: 16, color: .white, weight: .medium)
    
    private let descriptionLabel = TextLabel(label: "Пищевая ценность на 100 г", size: 13, color: .lightGray)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public update
    func update(_ productName: String) {
        nameLabel.text = productName
    }
}

extension NutrientsHeaderView {
    private func setupViews() {
        self.frame = CGRect(x: 0, y: 0, width: 300, height: 80)

        self.addSubview(nameLabel)
        self.addSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.left.right.equalTo(self).inset(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.left.right.equalTo(self).inset(16)
            make.bottom.equalTo(self).inset(16)
        }
    }
}
