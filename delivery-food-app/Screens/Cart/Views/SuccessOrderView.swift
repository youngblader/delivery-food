//
//  SuccessOrderView.swift
//  delivery-food-app
//
//  Created by Eugene on 26.06.23.
//

import UIKit
import SnapKit

final class SuccessOrderView: UIViewController {
    var onDismissTapped: (()->())?
    
    private let titleLabel = TextLabel(label: "Заказ успешно оформлен", size: 18, weight: .bold)

    private let subTitleLabel = TextLabel(label: "Ваш заказ был оформлен. Вы можете отслеживать статус вашего заказа в разделе Мои заказы.", size: 16, weight: .light, aligment: .center)
    
    private let containerStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 10
        
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stack.isLayoutMarginsRelativeArrangement = true
        
        stack.alignment = .center
        
        return stack
    }()
    
    private let placedOrderImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "success_order")
        imageView.contentMode = .scaleAspectFit
        
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        return imageView
    }()
    
    private lazy var placedOrderButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Отлично", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        
        button.layer.cornerRadius = 18
        button.backgroundColor = .orange
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        button.addTarget(self, action: #selector(dismissTapped(sender:)), for: .touchUpInside)
        
        return button
    }()
    
    override func loadView() {
        super.loadView()
        
        setup()
        setupViews()
        setupConstraints()
    }
    
    @objc private func dismissTapped(sender: UIButton) {
        sender.showAnimation {
            self.onDismissTapped?()
            self.dismiss(animated: true)
        }
    }
}

extension SuccessOrderView {
    private func setup() {
        view.backgroundColor = .white
    }
    
    private func setupViews() {
        view.addSubview(containerStack)
        
        containerStack.addArrangedSubview(placedOrderImage)
        containerStack.addArrangedSubview(titleLabel)
        containerStack.addArrangedSubview(subTitleLabel)
        
        view.addSubview(placedOrderButton)
    }
    
    private func setupConstraints() {
        containerStack.snp.makeConstraints { make in
            make.top.equalTo(view).inset(14)
            make.left.right.equalTo(view)
        }
        
        placedOrderButton.snp.makeConstraints { make in
            make.left.right.equalTo(view).inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
