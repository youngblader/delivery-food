//
//  Benefit.swift
//  delivery-food-app
//
//  Created by Eugene on 23.03.23.
//

import Foundation

struct BenefitsResponse: Codable {
    let benefits: [Benefit]
}

struct Benefit: Codable {
    let title, subTitle, description, image: String
}
