//
//  SearchResultsTableView.swift
//  delivery-food-app
//
//  Created by Eugene on 31.05.23.
//

import UIKit

final class SearchResultsTableView: UITableView {
    private var products: [Product] = []
    private var isFiltering: Bool = false
    
    var onSelectProductTapped: ((Product)->())?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: .zero, style: .plain)
        
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = .none
        
        self.register(SearchResultCell.self, forCellReuseIdentifier: SearchResultCell.reuseId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public update
    func update(_ products: [Product], _ isFiltering: Bool) {
        self.products = products
        self.isFiltering = isFiltering

        self.reloadData()
    }
}

extension SearchResultsTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let completion = {
            let product = self.products[indexPath.row]
            self.onSelectProductTapped?(product)
        }

        tableView.cellForRow(at: indexPath)?.showAnimation(completion)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return products.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.reuseId, for: indexPath) as! SearchResultCell
        
        cell.selectionStyle = .none
        
        let product = products[indexPath.row]
        
        cell.update(product)
        
        return cell
    }
}
