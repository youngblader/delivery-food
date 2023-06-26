//
//  DetailBenefitView.swift
//  delivery-food-app
//
//  Created by Eugene on 23.03.23.
//

import UIKit
import SnapKit

final class DetailBenefitView: UIView {
    private var selectedBenefit: Benefit?

    var onDismissController: (()->())?
    
    private lazy var closeButton = CloseButton()

    private let titleLabel = TextLabel(size: 20, weight: .medium)
    private let subTitleLabel = TextLabel(size: 18)
    private let descriptionLabel = TextLabel(size: 16)
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        
        return scroll
    }()
    
    private let containerStackView: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 10
        
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stack.isLayoutMarginsRelativeArrangement = true
        
        stack.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        
        return stack
    }()
    
    private let containerView: UIView = {
        let view = UIView()

        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleToFill
        imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public update
    func update(_ benefit: Benefit) {
        selectedBenefit = benefit
        
        imageView.image = UIImage(named: benefit.image)
        titleLabel.text = benefit.title
        subTitleLabel.text = benefit.subTitle
        descriptionLabel.text = benefit.description
    }
    
    @objc func dismiss() {
        onDismissController?()
    }
}

extension DetailBenefitView {
    private func setup() {
        self.backgroundColor = .white
        closeButton.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
    }
    
    private func setupViews() {
        self.addSubview(imageView)
        self.addSubview(containerView)

        containerView.addSubview(scrollView)
        scrollView.addSubview(containerStackView)

        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(subTitleLabel)
        containerStackView.addArrangedSubview(descriptionLabel)
        
        self.addSubview(closeButton)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.left.right.equalTo(self)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.left.right.bottom.equalTo(self)
        }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(containerView)
        }
        
        containerStackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.right.equalTo(self).inset(16)
        }
    }
}
