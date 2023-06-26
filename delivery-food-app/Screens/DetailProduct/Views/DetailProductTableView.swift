//
//  DetailProductTableView.swift
//  delivery-food-app
//
//  Created by Eugene on 14.03.23.
//

import UIKit
import SnapKit

private enum TableViewSections: Int, CaseIterable {
    case productInfo = 0
    case modificators = 1
}

final class DetailProductTableView: UITableView {
    private var selectedProduct: Product?
     
    var onAboutButtonTapped: (()->())?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: .zero, style: style)
        
        self.allowsSelection = false
        
        self.delegate = self
        self.dataSource = self
        
        self.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        self.separatorStyle = .none
        
        self.register(ProductInfoCell.self, forCellReuseIdentifier: ProductInfoCell.reuseId)
        self.register(AddModificatorsCell.self, forCellReuseIdentifier: AddModificatorsCell.reuseId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public update
    func update(_ product: Product) {
        self.selectedProduct = product
    }
}

extension DetailProductTableView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return TableViewSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = TableViewSections(rawValue: section)
        
        switch (section) {
        case .productInfo:
            return 1
        case .modificators:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = TableViewSections(rawValue: indexPath.section)
        
        switch section {
        case .productInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductInfoCell.reuseId, for: indexPath) as! ProductInfoCell
            
            cell.onAboutButtonTapped = {
                self.onAboutButtonTapped?()
            }
            
            if let product = selectedProduct {
                cell.update(product)
            }
            
            return cell
        case .modificators:
            let cell = tableView.dequeueReusableCell(withIdentifier: AddModificatorsCell.reuseId, for: indexPath) as! AddModificatorsCell
            
            // first update cell, after update UI
            let product = selectedProduct!
            cell.update(product)
            
            let modificators = product.modificators?.modificatorsAvailableToAdd ?? []
            
            cell.frame = tableView.bounds
            cell.layoutIfNeeded()

            let layout: CGSize = cell.modificatorsCollectionView.collectionViewLayout.collectionViewContentSize

            cell.modificatorsCollectionView.heightAnchor.constraint(equalToConstant: layout.height).isActive = true
            
            if !modificators.isEmpty {
                return cell
            }

            return UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
}
