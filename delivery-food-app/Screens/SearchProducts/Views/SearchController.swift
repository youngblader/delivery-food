//
//  SearchController.swift
//  delivery-food-app
//
//  Created by Eugene on 4.06.23.
//

import UIKit

final class SearchController: UISearchController {
    var onFilterSearchProducts: ((String)->())?
    var onDismissTapped: (()->())?
    
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: nil)
    
        self.searchBar.placeholder = "Search"
        
        self.searchBar.showsCancelButton = true
        self.obscuresBackgroundDuringPresentation = false
        self.hidesNavigationBarDuringPresentation = false
        
        self.delegate = self
        self.searchResultsUpdater = self
        
        setupCancelButtonSearchBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public update
    func update(_ placeholder: String) {
        self.searchBar.placeholder = placeholder
    }
    
    @objc private func dismissController() {
        onDismissTapped?()
    }
}

extension SearchController: UISearchControllerDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        
        onFilterSearchProducts?(searchText)
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.async {
            searchController.searchBar.becomeFirstResponder()
        }
    }
    
    private func setupCancelButtonSearchBar() {
        if let cancelButton = self.searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.setTitle("Отменить", for: .normal)
            cancelButton.setTitleColor(UIColor.orange, for: .normal)
            cancelButton.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
        }
    }
}
