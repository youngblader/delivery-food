//
//  NutrientsTableView.swift
//  delivery-food-app
//
//  Created by Eugene on 21.05.23.
//

import UIKit
import SnapKit

final class NutrientsTableView: UITableView {
    private var nutrientsHeaderView = NutrientsHeaderView()
    private var nutrientsFooterView = NutrientsFooterView()
    
    private var nutrients: [Nutrient] = []
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: .zero, style: style)
        
        self.tableHeaderView = nutrientsHeaderView
        self.tableFooterView = nutrientsFooterView
    
        self.allowsSelection = false
        
        self.delegate = self
        self.dataSource = self
        
        self.backgroundColor = UIColor.clear
        self.separatorStyle = .none
        
        self.register(NutrientCell.self, forCellReuseIdentifier: NutrientCell.reuseId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public update
    func update(_ product: Product) {
        nutrients = product.nutrients ?? []
        nutrientsHeaderView.update(product.name)
        
        self.reloadData()
    }
}

extension NutrientsTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nutrients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NutrientCell.reuseId, for: indexPath) as! NutrientCell
        
        let nutrient = nutrients[indexPath.row]
        
        cell.update(nutrient)
        
        return cell
    }
}
