//
//  DetailBenefitViewController.swift
//  delivery-food-app
//
//  Created by Eugene on 23.03.23.
//

import UIKit
import SnapKit

final class DetailBenefitViewController: UIViewController {
    private let benefitProvider: BenefitsProvider

    var selectedBenefit: Benefit?
    
    private var detailBenefitView: DetailBenefitView {
        return self.view as! DetailBenefitView
    }
    
    override func loadView() {
        self.view = DetailBenefitView(frame: UIScreen.main.bounds)
    }
    
    init(provider: BenefitsProvider, selectedBenefit: Benefit?) {
        self.benefitProvider = provider
        self.selectedBenefit = selectedBenefit
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailBenefitView.update(selectedBenefit!)

        detailBenefitView.onDismissController = {
            self.dismiss()
        }
    }
    
    deinit {
        print(#function)
    }
    
    private func dismiss() {
        benefitProvider.router.dismiss(self)
    }
}
