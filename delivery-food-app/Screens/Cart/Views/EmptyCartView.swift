//
//  EmptyCartView.swift
//  delivery-food-app
//
//  Created by Eugene on 1.03.23.
//

import UIKit
import SnapKit

final class EmptyCartView: UIView {
    var onRedirectTapped: (()->())?
    
    private let containerStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 20
        
        return stack
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "empty-cart")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()

    private let textLabel = TextLabel(label: "Упс, ваша корзина пуста. \n Чтобы ее пополнить перейдите в меню", size: 16, weight: .medium, aligment: .center)
    
    private lazy var navigateButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Перейти в меню", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(UIColor.grayOrange, for: .normal)
        
        button.backgroundColor = UIColor.lightOrange
        button.layer.cornerRadius = 18

        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        button.addTarget(self, action: #selector(navigateTapped(sender:)), for: .touchUpInside)
        
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
    
    @objc func navigateTapped(sender: UIButton) {
        sender.showAnimation {
            self.onRedirectTapped?()
        }
    }
}

extension EmptyCartView {
    private func setupViews() {
        self.addSubview(containerStack)
        
        containerStack.addArrangedSubview(imageView)
        containerStack.addArrangedSubview(textLabel)
        containerStack.addArrangedSubview(navigateButton)
    }
    
    private func setupConstraints() {
        containerStack.snp.makeConstraints { make in
            make.left.right.equalTo(self).inset(20)
            make.centerY.centerX.equalTo(self)
        }
        
        imageView.snp.makeConstraints { make in
            make.right.left.equalTo(containerStack)
        }
        
        navigateButton.snp.makeConstraints { make in
            make.right.left.equalTo(containerStack).inset(20)
        }
    }
}
