//
//  MenuView.swift
//  delivery-food-app
//
//  Created by Eugene on 9.03.23.
//

import UIKit
import SnapKit

final class MenuView: UIView {
    lazy var menuTableView = MenuTableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public update
    func update(_ data: MenuData) {
        menuTableView.update(data)
    }
}

extension MenuView {
    private func setupViews() {
        self.backgroundColor = .white
        self.addSubview(menuTableView)
    }
    
    private func setupConstraints() {
        menuTableView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
