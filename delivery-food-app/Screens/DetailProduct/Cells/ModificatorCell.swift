//
//  ModificatorCell.swift
//  tms-hw-collectionView
//
//  Created by Eugene on 22.02.23.
//

import UIKit
import SnapKit

private enum UIConstants {
    static let imageSize: CGFloat = 90
    static let titleFontSize: CGFloat = 10
    static let priceFontSize: CGFloat = 16
    static let cellRadius: CGFloat = 12
    static let stackMargins: CGFloat = 10
}

final class ModificatorCell: UICollectionViewCell {
    static var reuseId = "ModificatorCell"

    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.animateSelectedCell(isSelected, UIColor.orange, 1, 0, 0, CGSize(width: 0, height: 0), 1.0)
            } else {
                self.animateSelectedCell(isSelected, UIColor.white, 0, 1.6, 8, CGSize(width: 2, height: 5), 0.0)
            }
        }
    }

    private func animateSelectedCell(_ isSelected: Bool, _ borderColor: UIColor, _ borderWidth: CGFloat, _ shadowOpacity: Float, _ shadowRadius: CGFloat, _ shadowOffset: CGSize, _ alpha: CGFloat) {
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.layer.borderColor = borderColor.cgColor
            self.contentView.layer.borderWidth = borderWidth
            
            self.contentView.layer.shadowOpacity = shadowOpacity
            self.contentView.layer.shadowRadius = shadowRadius
            self.contentView.layer.shadowOffset = shadowOffset
            
            if !isSelected {
                self.contentView.layer.shadowColor = UIColor.backgroundGray.cgColor
            }
            
            self.checkMarkImageView.alpha = alpha
        })
    }
    
    private let containerStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 8
        
        return stack
    }()
    
    private let checkMarkImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "checkmark.circle")
        
        imageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        imageView.tintColor = UIColor.orange
        imageView.alpha = 0.0
        
        return imageView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.widthAnchor.constraint(equalToConstant: UIConstants.imageSize).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: UIConstants.imageSize).isActive = true
        
        return imageView
    }()
    
    private let titleLabel = TextLabel(size: UIConstants.titleFontSize, aligment: .center)
    private let priceLabel = TextLabel(size: UIConstants.priceFontSize, weight: .medium, aligment: .center)
    
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
    func update(_ modificator: Modificator) {
        titleLabel.text = modificator.name
        priceLabel.text = "\(modificator.price) ₽"
        imageView.image = UIImage(named: modificator.image)
    }
}

extension ModificatorCell {
    private func setup() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = UIConstants.cellRadius
        
        contentView.layer.shadowOffset = CGSize(width: 2, height: 5)
        contentView.layer.shadowOpacity = 1.6
        contentView.layer.shadowRadius = 8
        contentView.layer.shadowColor = UIColor.backgroundGray.cgColor
    }
    
    private func setupViews() {
        contentView.addSubview(containerStack)
        
        containerStack.addArrangedSubview(imageView)
        containerStack.addArrangedSubview(titleLabel)
        containerStack.addArrangedSubview(priceLabel)
        
        contentView.addSubview(checkMarkImageView)
    }
    
    private func setupConstraints() {
        containerStack.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(UIConstants.stackMargins)
        }
        
        checkMarkImageView.snp.makeConstraints { make in
            make.top.right.equalTo(contentView).inset(5)
        }
    }
}
