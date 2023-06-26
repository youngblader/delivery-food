//
//  SupportView.swift
//  delivery-food-app
//
//  Created by Eugene on 3.03.23.
//

import UIKit
import SnapKit

final class SupportView: UIView {
    let supportLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Правовые документы"
        return label
    }()
    
    let iconImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "chevrone.right")
        
        imageView.backgroundColor = .red
        
        imageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        return imageView
    }()
    
//    let separatorView: UIView = {
//        let view = UIView()
//
//        view.layer.borderWidth = 1
//        view.layer.borderColor = UIColor.lightGray.cgColor
//
//        return view
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        self.backgroundColor = .green
        
        self.addSubview(supportLabel)
        self.addSubview(iconImage)
//        self.addSubview(separatorView)
    }
    
    private func setupConstraints() {
        supportLabel.snp.makeConstraints { make in
            make.edges.equalTo(self).inset(20)
        }
        
        iconImage.snp.makeConstraints { make in
            make.right.bottom.equalTo(self).inset(20)
        }
        
//        separatorView.snp.makeConstraints { make in
//            make.right.left.bottom.equalTo(self)
//        }
    }
}
