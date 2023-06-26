//
//  BenefitsCollectionView.swift
//  delivery-food-app
//
//  Created by Eugene on 23.03.23.
//

import UIKit
import SnapKit

final class BenefitsCollectionView: UICollectionView {
    private var benefits: [Benefit] = []
    
    var onSelectedBenefit: ((Benefit)->())?

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.itemSize = CGSize(width: 280, height: 200)
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        self.delegate = self
        self.dataSource = self
        self.register(BenefitCell.self, forCellWithReuseIdentifier: BenefitCell.reuseId)
        
        self.showsHorizontalScrollIndicator = false
        self.heightAnchor.constraint(equalToConstant: 220).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public update
    func update(_ benefits: [Benefit]) {
        self.benefits = benefits
        self.reloadData()
    }
}

extension BenefitsCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let benefit = benefits[indexPath.row]
        
        onSelectedBenefit?(benefit)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return benefits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BenefitCell.reuseId, for: indexPath) as! BenefitCell
        
        let benefit = benefits[indexPath.row]
        
        cell.update(benefit)
        
        return cell
    }
}
