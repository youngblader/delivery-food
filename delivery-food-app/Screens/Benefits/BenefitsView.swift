//
//  BenefitsView.swift
//  delivery-food-app
//
//  Created by Eugene on 9.03.23.
//

import UIKit
import SnapKit

final class BenefitsView: UIView {
    let benefitsCollectionView = BenefitsCollectionView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public update
    func update(_ benefits: [Benefit]) {
        benefitsCollectionView.update(benefits)
    }
}

extension BenefitsView {
    private func setup() {
        self.backgroundColor = .white
    }
    
    private func setupViews() {
        self.addSubview(benefitsCollectionView)
    }
    
    private func setupConstraints() {
        benefitsCollectionView.snp.makeConstraints { make in
            make.top.left.right.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
