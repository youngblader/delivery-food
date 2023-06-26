//
//  CategoryCell.swift
//  delivery-food-app
//
//  Created by Eugene on 2.03.23.
//

import UIKit
import SnapKit

final class CategoryCell: UICollectionViewCell {
    static let reuseId = "CategoryCell"
    
    private let categoryLabel = TextLabel(size: 15, color: .textGray, weight: .medium, aligment: .center)
    
    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = self.isSelected ? UIColor.lightOrange : UIColor.lightGray
            categoryLabel.textColor = self.isSelected ? UIColor.grayOrange : UIColor.textGray
        }
    }

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
    func update(_ category: Category) {
        categoryLabel.text = category.title
    }
}

extension CategoryCell {
    private func setup() {
        contentView.backgroundColor = UIColor.lightGray
        contentView.layer.cornerRadius = 18
    }
    
    private func setupViews() {
        contentView.addSubview(categoryLabel)
    }
    
    private func setupConstraints() {
        categoryLabel.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
}
