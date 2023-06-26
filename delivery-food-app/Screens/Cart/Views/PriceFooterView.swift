//
//  PriceFooterView.swift
//  delivery-food-app
//
//  Created by Eugene on 28.02.23.
//

import UIKit
import SnapKit

final class PriceFooterView: UIView {
    private let separatorView = SeparatorView()
    
    var onAcceptOrderTapped: (()->())?

    private lazy var orderButton: UIButton = {
        var button = UIButton(type: .system)
        
        button.setTitle("Оформить заказ на \(0) ₽", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.white, for: .normal)

        button.layer.cornerRadius = 20
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        button.backgroundColor = .orange
        
        button.addTarget(self, action: #selector(acceptOrder(sender:)), for: .touchUpInside)
        
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
    func update(_ price: Int) {
        orderButton.setTitle("Оформить заказ на \(price) ₽", for: .normal)
    }
    
    @objc private func acceptOrder(sender: UIButton) {
        sender.showAnimation {
            self.onAcceptOrderTapped?()
        }
    }
}

extension PriceFooterView {
    private func setupViews() {
        self.addSubview(separatorView)
        self.addSubview(orderButton)
    }
    
    private func setupConstraints() {
        separatorView.snp.makeConstraints { make in
            make.left.right.equalTo(self)
            make.top.equalTo(self.snp.top)
        }

        orderButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(self).inset(15)
            make.left.right.equalTo(self).inset(20)
        }
    }
}
