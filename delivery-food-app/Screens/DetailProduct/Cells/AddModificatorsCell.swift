//
//  AddModificatorsCell.swift
//  delivery-food-app
//
//  Created by Eugene on 14.03.23.
//

import UIKit
import SnapKit

final class AddModificatorsCell: UITableViewCell {
    static var reuseId = "AddModificatorsCell"

    let modificatorsCollectionView = ModificatorsCollectionView()
    
    private let titleLabel = TextLabel(label: "Добавить по вкусу", size: 16, weight: .medium)

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
        modificatorsCollectionView.update(product)
    }
}

extension AddModificatorsCell {
    private func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(modificatorsCollectionView)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(20)
            make.left.right.equalTo(contentView).inset(20)
        }
        
        modificatorsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.right.bottom.equalTo(contentView)
        }
    }
}
