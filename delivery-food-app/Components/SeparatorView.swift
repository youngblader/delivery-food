//
//  SeparatorView.swift
//  delivery-food-app
//
//  Created by Eugene on 10.04.23.
//

import UIKit

final class SeparatorView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.borderColor.cgColor
        self.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
