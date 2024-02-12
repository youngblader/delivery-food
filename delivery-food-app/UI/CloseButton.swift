//
//  CloseButton.swift
//  delivery-food-app
//
//  Created by Eugene on 24.03.23.
//

import UIKit
import SnapKit

final class CloseButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setImage(UIImage(systemName: "xmark"), for: .normal)
        self.backgroundColor = .white
        self.tintColor = .gray
        
        self.contentMode = .center
        
        self.widthAnchor.constraint(equalToConstant: 32).isActive = true
        self.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        self.layer.cornerRadius = 16
        
        self.layer.shadowOpacity = 1.6
        self.layer.shadowRadius = 8
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowColor = UIColor.backgroundGray.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
