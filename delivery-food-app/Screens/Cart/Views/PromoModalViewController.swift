//
//  PromoModalViewController.swift
//  delivery-food-app
//
//  Created by Eugene on 29.03.23.
//

import UIKit
import SnapKit

final class PromoModalViewController: UIViewController {
    let defaultHeight: CGFloat = 350
    let maxDimmedAlpha: CGFloat = 0.6
    
    let dismissibleHeight: CGFloat = 350
    let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 64
    var currentContainerHeight: CGFloat = 350
    
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    private let promoLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Ввести промокод"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        
        return label
    }()
    
    private let promoTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "Введите промокод"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.grayOrange.cgColor
        
        let paddingView = UIView(frame: CGRectMake(0, 0, 16, textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        textField.tintColor = UIColor.grayOrange
        
        textField.layer.cornerRadius = 18
        textField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        return textField
    }()
    
    private let applyPromoButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Применить промокод", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        
        button.layer.cornerRadius = 18
        button.backgroundColor = .orange
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        button.addTarget(self, action: #selector(dismissTapped(sender:)), for: .touchUpInside)
        
        return button
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var dimmedView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .black
        view.alpha = maxDimmedAlpha
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPanGesture()
        setupView()
        setupConstraints()
    }
    
    private func animateShowDimmedView() {
        dimmedView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = self.maxDimmedAlpha
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateShowDimmedView()
        animatePresentContainer()
    }
    
    private func animatePresentContainer() {
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = 0
            // Call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
    }
    
    private func animateDismissView() {
        // hide main container view by updating bottom constraint in animation block
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = self.defaultHeight
            // call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
        
        // hide blur view
        dimmedView.alpha = maxDimmedAlpha
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            // once done, dismiss without animation
            self.dismiss(animated: false)
        }
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        // Drag to top will be minus value and vice versa
        print("Pan gesture y offset: \(translation.y)")
        
        // Get drag direction
        let isDraggingDown = translation.y > 0
        print("Dragging direction: \(isDraggingDown ? "going down" : "going up")")
        
        // New height is based on value of dragging plus current container height
        let newHeight = currentContainerHeight - translation.y
        
        // Handle based on gesture state
        switch gesture.state {
        case .changed:
            // This state will occur when user is dragging
            if newHeight < maximumContainerHeight {
                // Keep updating the height constraint
                containerViewHeightConstraint?.constant = newHeight
                // refresh layout
                view.layoutIfNeeded()
            }
        case .ended:
            // This happens when user stop drag,
            // so we will get the last height of container
            // Condition 1: If new height is below min, dismiss controller
            if newHeight < dismissibleHeight {
                self.animateDismissView()
            }
            else if newHeight < defaultHeight {
                // Condition 2: If new height is below default, animate back to default
                animateContainerHeight(defaultHeight)
            }
            else if newHeight < maximumContainerHeight && isDraggingDown {
                // Condition 3: If new height is below max and going down, set to default height
                animateContainerHeight(defaultHeight)
            }
            else if newHeight > defaultHeight && !isDraggingDown {
                // Condition 4: If new height is below max and going up, set to max height at top
                animateContainerHeight(maximumContainerHeight)
            }
        default:
            break
        }
    }
    
    private func setupPanGesture() {
        // add pan gesture recognizer to the view controller's view (the whole screen)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(_:)))
        
        // change to false to immediately listen on gesture movement
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(panGesture)
    }
    
    private func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            // Update container height
            self.containerViewHeightConstraint?.constant = height
            // Call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
        // Save current height
        currentContainerHeight = height
    }
    
    @objc private func dismissTapped(sender: UIButton) {
        sender.showAnimation {
            
            // animateDismissView()
            self.dimmedView.alpha = self.maxDimmedAlpha
            UIView.animate(withDuration: 0.4) {
                self.dimmedView.alpha = 0
            } completion: { _ in
                // once done, dismiss without animation
                self.dismiss(animated: true)
            }

            UIView.animate(withDuration: 0.3) {
                self.containerViewBottomConstraint?.constant = self.defaultHeight
                // call this to trigger refresh constraint
                self.view.layoutIfNeeded()
            }
        }
    }
}

extension PromoModalViewController {
    private func setupView() {
        view.backgroundColor = .clear
        
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        
        containerView.addSubview(promoLabel)
        containerView.addSubview(promoTextField)
        containerView.addSubview(applyPromoButton)
    }
    
    private func setupConstraints() {
        dimmedView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        containerView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view)
        }
        
        promoLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView).inset(40)
            make.top.left.right.equalTo(containerView).inset(16)
        }
        
        promoTextField.snp.makeConstraints { make in
            make.top.equalTo(promoLabel.snp.bottom).offset(20)
            make.left.right.equalTo(containerView).inset(16)
        }
        
        applyPromoButton.snp.makeConstraints { make in
            make.bottom.equalTo(containerView.safeAreaLayoutGuide)
            make.left.right.equalTo(containerView).inset(16)
        }
        
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
    }
}
