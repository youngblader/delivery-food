//
//  MenuCollectionView.swift
//  delivery-food-app
//
//  Created by Eugene on 10.03.23.
//

import UIKit
import SnapKit

final class MenuCollectionView: UICollectionView {
    private var products: [Product] = []
    
    var onSelectedProduct: ((Product)->())?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.75, height: UIScreen.main.bounds.width * 0.38)
        
        layout.minimumLineSpacing = 16
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        self.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        self.delegate = self
        self.dataSource = self
        self.register(MenuProductCell.self, forCellWithReuseIdentifier: MenuProductCell.reuseId)
        
        self.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public update
    func update(_ products: [Product]) {
        self.products = products
        self.reloadData()
    }
}

extension MenuCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let completion = {
            let product = self.products[indexPath.row]
            self.onSelectedProduct?(product)
        }

        collectionView.cellForItem(at: indexPath)?.showAnimation(completion)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.dequeueReusableCell(withReuseIdentifier: MenuProductCell.reuseId, for: indexPath) as! MenuProductCell
        
        let product = products[indexPath.row]
        
        cell.update(product)
        
        return cell
    }
}
