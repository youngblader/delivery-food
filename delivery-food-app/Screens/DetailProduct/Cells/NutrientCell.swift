//
//  NutrientCell.swift
//  delivery-food-app
//
//  Created by Eugene on 21.05.23.
//

import UIKit
import SnapKit

final class NutrientCell: UITableViewCell {
    static var reuseId = "NutrientCell"
    
    private let nameLabel = TextLabel(label: "", size: 14, color: .white, weight: .medium)
    private let valueLabel = TextLabel(label: "", size: 14, color: .white, weight: .medium)
    
    private let containerStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        
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
    
    //MARK: Public update
    func update(_ nutrient: Nutrient) {
        nameLabel.text = nutrient.name
        valueLabel.text = nutrient.value
    }
}

extension NutrientCell {
    private func setupViews() {
        self.backgroundColor = UIColor.clear

        contentView.addSubview(containerStack)

        containerStack.addArrangedSubview(nameLabel)
        containerStack.addArrangedSubview(valueLabel)
    }
    
    private func setupConstraints() {
        containerStack.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.bottom.equalTo(contentView).inset(5)
            make.left.right.equalTo(contentView).inset(16)
        }
    }
}
