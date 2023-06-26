//
//  DetailProductViewController.swift
//  delivery-food-app
//
//  Created by Eugene on 12.03.23.А
//

import UIKit
import SnapKit

final class DetailProductViewController: UINavigationController {
    private let menuProvider: MenuProvider
    
    private var selectedProduct: Product?
    
    private var isHiddenNutrientsView: Bool = false
    
    private var detailProductView: DetailProductView {
        return self.view as! DetailProductView
    }
    
    override func loadView() {
        self.view = DetailProductView(frame: UIScreen.main.bounds)
    }
    
    init(provider: MenuProvider, product: Product) {
        self.menuProvider = provider
        self.selectedProduct = product

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailProductView.onDismissController = {
            self.dismiss()
        }
        
        detailProductView.onUpdateProducts = { products in
            self.menuProvider.menuArhiver.save(products)
        }

        detailProductView.onPresentNutrientsProductView = {
            self.presentNutrientsProductView()
        }
        
        if let product = (selectedProduct) {
            product.modificators?.modificatorsToAdd = [] // for clear modificators
            detailProductView.update(product, menuProvider.menuArhiver.retrieve())
        }
    }
    
    private func presentNutrientsProductView() {
        if !isHiddenNutrientsView {
            animateNutrientsProductView(1.0)
        } else {
            animateNutrientsProductView(0.0)
        }
    }
    
    private func animateNutrientsProductView(_ alpha: CGFloat) {
        UIView.animate(withDuration: 0.5, animations: {
            self.detailProductView.nutrientsProductView.alpha = alpha
        })
        
        isHiddenNutrientsView.toggle()
    }
    
    private func dismiss() {
        menuProvider.router.dismiss(self)
    }
}
