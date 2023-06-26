//
//  AddAddressView.swift
//  delivery-food-app
//
//  Created by Eugene on 5.04.23.
//

import UIKit
import SnapKit

private enum orderingOptions: String, CaseIterable {
    case delivery = "На доставку"
    case hall = "В зале"
}

final class AddAddressView: UIView {
    private let separatorView = SeparatorView()
    
    private let containerStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 0
        
        stack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 10, right: 16)
        stack.isLayoutMarginsRelativeArrangement = true
        
        stack.backgroundColor = .lightGray
        stack.layer.cornerRadius = 16
        
        return stack
    }()

    private let addressButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Указать адрес доставки", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(UIColor.grayOrange, for: .normal)
        
        button.setImage(UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .medium, scale: .small)), for: .normal)
        
        button.semanticContentAttribute = .forceRightToLeft
        
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 14.0, bottom: 0, right: 4.0)
        
        button.tintColor = UIColor.grayOrange
        
        return button
    }()
    
    private var segmentControl: UISegmentedControl = {
        let control = UISegmentedControl(items: orderingOptions.allCases.map { $0.rawValue })
    
        control.selectedSegmentIndex = 0

        return control
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AddAddressView {
    private func setupViews() {
        self.addSubview(containerStack)

        containerStack.addArrangedSubview(segmentControl)
        containerStack.addArrangedSubview(separatorView)
        containerStack.addArrangedSubview(addressButton)
    }
    
    private func setupConstraints() {
        containerStack.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
}
