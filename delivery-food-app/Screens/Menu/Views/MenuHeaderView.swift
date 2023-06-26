//
//  MenuHeaderView.swift
//  delivery-food-app
//
//  Created by Eugene on 28.03.23.
//

import UIKit
import SnapKit

final class MenuHeaderView: UIView {
    private let addAddressView = AddAddressView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
        setupViews()
        setupConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuHeaderView {
    private func setup() {
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 115)
    }
    
    private func setupViews() {
        self.addSubview(addAddressView)
    }
    
    private func setupConstraints() {
        addAddressView.snp.makeConstraints { make in
            make.top.left.right.equalTo(self).inset(16)
            make.bottom.equalTo(self)
        }
    }
}
