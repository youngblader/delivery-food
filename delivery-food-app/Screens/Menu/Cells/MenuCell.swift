//
//  MenuCell.swift
//  delivery-food-app
//
//  Created by Eugene on 10.03.23.
//

import UIKit
import SnapKit

final class MenuCell: UITableViewCell {
    static var reuseId = "MenuCell"
    
    private lazy var menuCollectionView = MenuCollectionView()
    private let categoryTitle = TextLabel(size: 18, weight: .bold)
    
    private var menuProducts: [Product] = []
    
    var onSelectedProduct: ((Product)->())?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
        
        menuCollectionView.onSelectedProduct = { product in
            self.onSelectedProduct?(product)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public
    func update(_ category: Category, _ products: [Product]) {
        menuProducts = products
        categoryTitle.text = category.title
        menuCollectionView.update(products)
    }
}

extension MenuCell {
    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.addSubview(categoryTitle)
        contentView.addSubview(menuCollectionView)
    }
    
    private func setupConstraints() {
        categoryTitle.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(5)
            make.left.right.equalTo(contentView).inset(16)
        }
        
        menuCollectionView.snp.makeConstraints { make in
            make.top.equalTo(categoryTitle.snp.bottom)
            make.left.right.bottom.equalTo(contentView)
        }
    }
}
