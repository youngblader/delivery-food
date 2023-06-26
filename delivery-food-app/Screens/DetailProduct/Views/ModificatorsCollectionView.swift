//
//  ModificatorsCollectionView.swift
//  delivery-food-app
//
//  Created by Eugene on 14.03.23.
//

import UIKit
import SnapKit

private enum UIConstants {
    static let cellCount: CGFloat = 3
    static let padding: CGFloat = 20
}

final class ModificatorsCollectionView: UICollectionView {
    var selectProduct: Product?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let cellCount: CGFloat = UIConstants.cellCount
        let padding: CGFloat = UIConstants.padding
        let paddingCount: CGFloat = cellCount
        
        let paddingSize: CGFloat = paddingCount * padding
        let cellWidth: CGFloat = (UIScreen.main.bounds.width - paddingSize) / cellCount
        let cellHeight: CGFloat = cellWidth * 1.6
        
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        
        layout.sectionInset = UIEdgeInsets(top: 15, left: padding, bottom: padding, right: padding)
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        self.isScrollEnabled = false
        self.allowsMultipleSelection = true
        
        self.delegate = self
        self.dataSource = self
        self.register(ModificatorCell.self, forCellWithReuseIdentifier: ModificatorCell.reuseId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public update
    func update(_ product: Product) {
        self.selectProduct = product
    }
    
    private func selectedModificators(_ modificator: Modificator) {
        var modificators = selectProduct?.modificators?.modificatorsToAdd ?? []
        
        let isRepeatModificator = isRepeatModificator(modificators, modificator)
        
        if modificators.isEmpty || !isRepeatModificator {
            modificators.append(modificator)
        } else {
            if let index = modificators.firstIndex(where: { $0.id == modificator.id }) {
                modificators.remove(at: index)
            }
        }
        
        selectProduct?.modificators?.modificatorsToAdd = modificators
    }
    
    private func isRepeatModificator(_ array: [Modificator], _ item: Modificator) -> Bool {
        return array.contains(where: { $0.id == item.id })
    }
}

extension ModificatorsCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let modificator = selectProduct?.modificators?.modificatorsAvailableToAdd?[indexPath.row] {
            selectedModificators(modificator)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectProduct?.modificators?.modificatorsAvailableToAdd!.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ModificatorCell.reuseId, for: indexPath) as! ModificatorCell
        
        if let modificator = selectProduct?.modificators?.modificatorsAvailableToAdd?[indexPath.row] {
            cell.update(modificator)
        }
        
        return cell
    }
}
