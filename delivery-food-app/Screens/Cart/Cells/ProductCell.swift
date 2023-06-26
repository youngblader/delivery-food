//
//  ProductCell.swift
//  delivery-food-app
//
//  Created by Eugene on 28.02.23.
//

import UIKit
import SnapKit

final class ProductCell: UITableViewCell {
    static let reuseId = "ProductCell"
    
    var counterView = CounterView()
    
    private let titleLabel: UILabel = {
        let label = TextLabel(size: 16, weight: .bold)
        
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        return label 
    }()
    
    private let detailLabel: UILabel = {
        let label = TextLabel(size: 12, color: .textGray, weight: .medium)
        
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        return label
    }()

    private let priceLabel = TextLabel(size: 18, weight: .medium)
    private let modificatorsLabel = TextLabel(size: 10, color: .textGray)
    
    private let detailView: UIStackView = {
        let stack = UIStackView()

        stack.axis = .vertical
        stack.spacing = 0
        stack.alignment = .leading

        stack.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
    
        return stack
    }()
    
    private let horizontalStack: UIStackView = {
        let stack = UIStackView()

        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .fillProportionally

        return stack
    }()
    
    private let productImageView: UIImageView = {
        let productImage = UIImageView()

        productImage.contentMode = .scaleAspectFit

        productImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        productImage.heightAnchor.constraint(equalToConstant: 100).isActive = true

        return productImage
    }()
    
    private let footerStackView: UIStackView = {
        let stack = UIStackView()

        stack.axis = .horizontal

        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getProductPrice(_ product: Product) -> Int {
        let modificatorsPrice = product.modificators?.modificatorsToAdd?.reduce(0, { result, curr in
            result + curr.price
        }) ?? 0
        
       return (product.price + modificatorsPrice) * (product.count ?? 1)
    }
    
    private func getModificatorsString(_ modificators: [Modificator]) -> String {
        if !modificators.isEmpty {
            return "+ \(modificators.map({ $0.name.lowercased() }).joined(separator: ", "))"
        }
        
        return ""
    }
    
    //MARK: Public update
    func update(_ product: Product, _ counterIndex: Int) {
        let modificators = product.modificators?.modificatorsToAdd ?? []
        
        titleLabel.text = product.name
        detailLabel.text = product.size
        priceLabel.text = "\(getProductPrice(product)) ₽"
    
        productImageView.image = UIImage(named: product.image)
        modificatorsLabel.text = getModificatorsString(modificators)
        
        counterView.countValue = product.count ?? 1
        counterView.index = counterIndex
    }
}

extension ProductCell {
    private func setupViews() {
        contentView.addSubview(horizontalStack)
        contentView.addSubview(footerStackView)
    
        horizontalStack.addArrangedSubview(productImageView)
        horizontalStack.addArrangedSubview(detailView)
        
        detailView.addArrangedSubview(titleLabel)
        detailView.addArrangedSubview(detailLabel)
        detailView.addArrangedSubview(modificatorsLabel)

        footerStackView.addArrangedSubview(priceLabel)
        footerStackView.addArrangedSubview(counterView)
    }
    
    private func setupConstraints() {
        horizontalStack.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(10)
            make.left.right.equalTo(contentView).inset(20)
        }
        
        footerStackView.snp.makeConstraints { make in
            make.top.equalTo(horizontalStack.snp.bottom).offset(15)
            make.left.right.equalTo(contentView).inset(20)
            make.bottom.equalTo(contentView).inset(10)
        }
    }
}
