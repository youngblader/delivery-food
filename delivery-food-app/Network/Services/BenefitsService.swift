//
//  BenefitsService.swift
//  delivery-food-app
//
//  Created by Eugene on 23.03.23.
//

import Foundation

protocol BenefitsService {
    func fetchBenefits() async throws -> [Benefit]
}

final class BenefitsServiceImpl: BenefitsService, API {
    func fetchBenefits() async throws -> [Benefit] {
        return try await request(endpoint: BenefitEndpoint.getBenefits, responseModel: BenefitsResponse.self).benefits
    }
}
