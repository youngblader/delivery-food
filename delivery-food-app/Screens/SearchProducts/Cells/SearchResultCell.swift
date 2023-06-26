//
//  SearchResultCell.swift
//  delivery-food-app
//
//  Created by Eugene on 31.05.23.
//

import UIKit
import SnapKit

final class SearchResultCell: UITableViewCell {
    static let reuseId = "SearchResultCell"
    
    private let nameLabel = TextLabel(size: 16, weight: .medium)
    private let descriptionLabel = TextLabel(size: 13, color: .textGray, linesNumber: 4)
    
    private let contentStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 12
        
        stack.alignment = .leading
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
        stack.isLayoutMarginsRelativeArrangement = true
        
        return stack
    }()

    private let productImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 135).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 135).isActive = true

        return imageView
    }()

    private let priceButton: UIButton = {
        let button = UIButton()

        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.setTitleColor(UIColor.grayOrange, for: .normal)

        button.backgroundColor = UIColor.lightOrange
        button.layer.cornerRadius = 17

        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)

        return button
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
        nameLabel.text = product.name
        descriptionLabel.text = product.description
        productImageView.image = UIImage(named: product.image)
        priceButton.setTitle("от \(product.price) ₽", for: .normal)
    }
}

extension SearchResultCell {
    private func setupViews() {
        contentView.addSubview(productImageView)
        contentView.addSubview(contentStack)
        
        contentStack.addArrangedSubview(nameLabel)
        contentStack.addArrangedSubview(descriptionLabel)
        contentStack.addArrangedSubview(priceButton)
    }
    
    private func setupConstraints() {
        productImageView.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(16)
            make.centerY.equalTo(contentView)
        }

        contentStack.snp.makeConstraints { make in
            make.top.right.bottom.equalTo(contentView).inset(16)
            make.left.equalTo(productImageView.snp.right)
        }
    }
}
