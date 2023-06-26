//
//  MenuProductCell.swift
//  delivery-food-app
//
//  Created by Eugene on 10.03.23.
//

import UIKit
import SnapKit

final class MenuProductCell: UICollectionViewCell {
    static var reuseId: String = "MenuProductCell"
    
    private let productTitleLabel = TextLabel(size: 16, weight: .medium, linesNumber: 0)

    private let productImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        return imageView
    }()
    
    private let productInfoView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private let productPriceButton: UIButton = {
        let button = UIButton()

        button.setTitle("", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.setTitleColor(UIColor.grayOrange, for: .normal)

        button.backgroundColor = UIColor.lightOrange
        button.layer.cornerRadius = 17

        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)

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
    
    //MARK: Public update
    func update(_ product: Product) {
        productTitleLabel.text = product.name
        productImageView.image = UIImage(named: product.image)
        productPriceButton.setTitle("от \(product.price) ₽", for: .normal)
    }
}

extension MenuProductCell {
    private func setup() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        
        contentView.layer.shadowOffset = CGSize(width: 0, height: 5)
        contentView.layer.shadowOpacity = 1.6
        contentView.layer.shadowRadius = 8
        contentView.layer.shadowColor = UIColor.backgroundGray.cgColor
    }
    
    private func setupViews() {
        contentView.addSubview(productImageView)
        contentView.addSubview(productInfoView)
        
        productInfoView.addSubview(productTitleLabel)
        productInfoView.addSubview(productPriceButton)
    }
    
    private func setupConstraints() {
        productImageView.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(16)
            make.centerY.equalTo(contentView)
        }

        productInfoView.snp.makeConstraints { make in
            make.top.right.bottom.equalTo(contentView).inset(16)
            make.left.equalTo(productImageView.snp.right).offset(10)
        }
        
        productTitleLabel.snp.makeConstraints { make in
            make.top.right.equalTo(productInfoView)
            make.left.equalTo(productInfoView)
        }
        
        productPriceButton.snp.makeConstraints { make in
            make.top.equalTo(productTitleLabel.snp.bottom).offset(10)
            make.left.equalTo(productInfoView)
            make.bottom.equalTo(productInfoView)
        }
    }
}
