//
//  ProductInfoCell.swift
//  delivery-food-app
//
//  Created by Eugene on 14.03.23.
//

import UIKit
import SnapKit

final class ProductInfoCell: UITableViewCell {
    static var reuseId = "ProductInfoCell"
    
    private let productTitle = TextLabel(size: 20, weight: .medium)
    private let detailLabel = TextLabel(size: 15, color: .textGray)
    private let descriptionLabel = TextLabel(size: 15)
    
    var onAboutButtonTapped: (()->())?
    
    private let containerStack: UIStackView = {
        let stack = UIStackView()

        stack.axis = .vertical
        stack.distribution = .equalSpacing

        return stack
    }()
    
    private let aboutProductStack: UIStackView = {
        let stack = UIStackView()

        stack.axis = .horizontal
        stack.distribution = .equalSpacing

        return stack
    }()
    
    private lazy var aboutNutrientsButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.setImage(UIImage(systemName: "info.circle"), for: .normal)
        
        button.widthAnchor.constraint(equalToConstant: 25).isActive = true
        button.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        button.tintColor = UIColor.textGray
        
        button.addTarget(self, action: #selector(presentNutrientsView), for: .touchUpInside)
        
        return button
    }()
    
    private let productImage: UIImageView = {
        let productImage = UIImageView()

        productImage.image = UIImage(named: "")
        productImage.contentMode = .scaleAspectFit

        productImage.heightAnchor.constraint(equalToConstant: 240).isActive = true

        return productImage
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public update
    func update(_ product: Product) {
        let nutrients = product.nutrients ?? []
        
        let sizeText = product.size ?? ""
        let weightText = product.weight ?? ""
        
        let text = "\(sizeText) \(!weightText.isEmpty ? ", \(weightText)" : "")"
         
        if nutrients.isEmpty {
            aboutNutrientsButton.isHidden = true
        }

        if !text.isEmpty {
            detailLabel.text = text
        }

        productTitle.text = product.name
        descriptionLabel.text = product.description
        productImage.image = UIImage(named: product.image)
    }
    
    @objc func presentNutrientsView() {
        onAboutButtonTapped?()
    }
}

extension ProductInfoCell {
    private func setupViews() {
        contentView.addSubview(containerStack)

        containerStack.addArrangedSubview(productImage)
        containerStack.addArrangedSubview(aboutProductStack)
        
        aboutProductStack.addArrangedSubview(productTitle)
        aboutProductStack.addArrangedSubview(aboutNutrientsButton)
        
        containerStack.addArrangedSubview(detailLabel)
        containerStack.addArrangedSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        containerStack.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView)
            make.right.left.equalTo(contentView).inset(20)
        }
    }
}
