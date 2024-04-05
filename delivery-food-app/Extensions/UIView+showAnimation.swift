//
//  UIView+showAnimation.swift
//  delivery-food-app
//
//  Created by Eugene on 9.05.23.
//

import UIKit

extension UIView {
    func showAnimation(_ completion: @escaping () -> Void) {
        isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
            self.transform = CGAffineTransform.init(scaleX: 0.96, y: 0.96)
        }) { (done) in
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
                self.transform = CGAffineTransform.identity
            }) { _ in
                self.isUserInteractionEnabled = true
                completion()
            }
        }
    }
}
