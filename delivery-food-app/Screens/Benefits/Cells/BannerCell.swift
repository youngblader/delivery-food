//
//  File.swift
//  delivery-food-app
//
//  Created by Eugene on 3.03.23.
//

import UIKit
import SnapKit

final class BannerCell: UICollectionViewCell {
    static let reuseId = "BannerCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Своими руками"
        
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        
        return label
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Мастер-классы"
        
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white.withAlphaComponent(0.5)
        
        return label
    }()
    
    private let viewButton: UIButton = {
        let button = UIButton()
            
        button.setTitle("Смотреть", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(.black, for: .normal)

        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
        
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BannerCell {
    private func setupViews() {
        self.backgroundColor = .orange
        self.layer.cornerRadius = 12
        
        self.addSubview(titleLabel)
        self.addSubview(detailLabel)
        self.addSubview(viewButton)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.left.equalTo(self).inset(20)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalTo(self).inset(20)
        }
        
        viewButton.snp.makeConstraints { make in
            make.left.bottom.equalTo(self).inset(20)
        }
    }
}
