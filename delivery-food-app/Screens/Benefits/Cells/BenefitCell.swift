//
//  BenefitCell.swift
//  delivery-food-app
//
//  Created by Eugene on 23.03.23.
//

import UIKit
import SnapKit

final class BenefitCell: UICollectionViewCell {
    static let reuseId = "BenefitCell"

    private let titleLabel = TextLabel(size: 16, weight: .medium)
    private let subTitle = TextLabel(size: 14, color: .gray, weight: .medium)

    private let bannerImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "")

        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 140).isActive = true

        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public update
    func update(_ benefit: Benefit) {
        bannerImage.image = UIImage(named: benefit.image)
        titleLabel.text = benefit.title
        subTitle.text = benefit.subTitle
    }
}

extension BenefitCell {
    private func setupViews() {
        contentView.addSubview(bannerImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitle)
    }
    
    private func setupConstraints() {
        bannerImage.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(10)
            make.top.left.right.equalTo(contentView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(bannerImage.snp.bottom).offset(4)
            make.left.right.equalTo(contentView)
        }
        
        subTitle.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.right.equalTo(contentView)
        }
    }
}
