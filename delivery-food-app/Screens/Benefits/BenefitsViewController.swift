//
//  BenefitsViewController.swift
//  delivery-food-app
//
//  Created by Eugene on 1.03.23.
//

import UIKit
import SnapKit

final class BenefitsViewController: UIViewController {
    private let benefitsProvider: BenefitsProvider
    
    private var benefitsView: BenefitsView {
        return self.view as! BenefitsView
    }
    
    override func loadView() {
        self.view = BenefitsView(frame: UIScreen.main.bounds)
    }
    
    init(provider: BenefitsProvider) {
        self.benefitsProvider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        fetchBenefits()
        
        benefitsView.benefitsCollectionView.onSelectedBenefit = { [weak self] benefit in
            self?.showDetailBenefit(benefit)
        }
    }
    
    private func fetchBenefits() {
        Task {
            do {
                let benefits = try await benefitsProvider.benefitsService.fetchBenefits()
                benefitsView.update(benefits)
            } catch {
                print(error)
            }
        }
    }
    
    private func showDetailBenefit(_ benefit: Benefit) {
        benefitsProvider.router.navigateToDetailBenefit(benefit, self)
    }
    
    private func setup() {
        self.title = "Предложения"
    }
}
