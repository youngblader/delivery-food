//
//  NutrientsFooterView.swift
//  delivery-food-app
//
//  Created by Eugene on 24.05.23.
//

import UIKit
import SnapKit

final class NutrientsFooterView: UIView {
    private let textLabel = TextLabel(label: "Может содержать аллергены: глютен, молоко и продукты его переработки (в том числе лактозу), а также некоторые другие аллергены...", size: 14, color: .white, weight: .medium)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NutrientsFooterView {
    private func setupViews() {
        self.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
        self.addSubview(textLabel)
    }
    
    private func setupConstraints() {
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(self).inset(10)
            make.left.right.bottom.equalTo(self).inset(16)
        }
    }
}
