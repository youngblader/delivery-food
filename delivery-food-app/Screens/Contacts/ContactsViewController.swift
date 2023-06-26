//
//  ContactsViewController.swift
//  delivery-food-app
//
//  Created by Eugene on 3.03.23.
//

import UIKit
import SnapKit

final class ContactsViewController: UIViewController {
    let supportView = SupportView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        self.title = "Контакты"
        
        view.backgroundColor = .white
        view.addSubview(supportView)
    }
    
    private func setupConstraints() {
        supportView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
