//
//  CounterView.swift
//  delivery-food-app
//
//  Created by Eugene on 28.02.23.
//

import UIKit
import SnapKit

final class CounterView: UIControl {
    var index: Int = 0
    
    var countValue = 0 {
        didSet {
            countValue = countValue > 0 ? countValue : 0
            countLabel.text = "\(countValue)"
        }
    }
    
    private lazy var countLabel = TextLabel(size: 16, color: .textGray, weight: .medium)
    
    private let containerStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        
        return stack
    }()
    
    private lazy var increaseButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("+", for: .normal)
        button.setTitleColor(.textGray, for: .normal)
        button.layer.cornerRadius = 12
        
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var decreaseButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("-", for: .normal)
        button.setTitleColor(.textGray, for: .normal)
        button.layer.cornerRadius = 12
        
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonAction(_ sender: UIButton) {
        switch sender {
        case decreaseButton:
            countValue -= 1
        case increaseButton:
            countValue += 1
        default:
            break
        }
        sendActions(for: .valueChanged)
    }
}

extension CounterView {
    private func setup() {
        self.layer.cornerRadius = 16
        self.backgroundColor = UIColor.lightGray
        
        self.widthAnchor.constraint(equalToConstant: 98).isActive = true
        self.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    private func setupViews() {
        self.addSubview(containerStack)
        
        containerStack.addArrangedSubview(decreaseButton)
        containerStack.addArrangedSubview(countLabel)
        containerStack.addArrangedSubview(increaseButton)
    }
    
    private func setupConstraints() {
        containerStack.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
}
