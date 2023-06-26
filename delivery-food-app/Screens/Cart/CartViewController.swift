//
//  CartViewController.swift
//  delivery-food-app
//
//  Created by Eugene on 28.02.23.
//

import UIKit
import SnapKit

final class CartViewController: UIViewController {
    private let notificationCenter = NotificationCenter.default
    private let cartProvider: CartProvider
    
    var order = Order(products: [])
    
    // Load View
    private var cartView: CartView {
        return self.view as! CartView
    }
    
    override func loadView() {
        self.view = CartView(frame: UIScreen.main.bounds)
    }
    
    init(provider: CartProvider) {
        self.cartProvider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        cartView.emptyCartView.onRedirectTapped = {
            self.tabBarController?.selectedIndex = 0
        }
        
        cartView.onAcceptOrderTapped = {
            self.createOrder()
        }
        
        cartView.onUpdateProducts = { products in
            self.cartProvider.menuArchiver.save(products)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        order = Order(products: cartProvider.menuArchiver.retrieve())
        update()
    }
    
    private func presentSuccessOrderView() {
        let controller = SuccessOrderView()
        
        if let sheet = controller.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersGrabberVisible = true
        }
        
        self.present(controller, animated: true)
    }
    
    private func createOrder() {
        let order = Order(products: cartProvider.menuArchiver.remove())
        self.order = order
        
        cartView.update(Order(products: cartProvider.menuArchiver.remove()))
        
        notificationCenter.post(name: Notification.Name("UpdateBadgeValue"), object: nil, userInfo: ["count": order.count])
        
        self.presentSuccessOrderView()
    }
    
    //MARK: Public update
    private func update() {
        cartView.update(order)
    }
}

extension CartViewController {
    private func setup() {
        self.title = "Корзина"
    }
}
