//
//  BenefitEndpoint.swift
//  delivery-food-app
//
//  Created by Eugene on 13.04.23.
//

import Foundation

enum BenefitEndpoint {
    case getBenefits
}

extension BenefitEndpoint: Endpoint {
    var parameters: [URLQueryItem] {
        switch self {
        case .getBenefits:
            return []
        }
    }
    
    var method: NetworkMethod {
        switch self {
        case .getBenefits:
            return .get
        }
    }
    
    var headers: [String : String]? {
        let accessToken = ""
        switch self {
        case .getBenefits:
            return [
                "Authorization": "Bearer \(accessToken)",
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .getBenefits:
            return nil
        }
    }
    
    var path: String {
        switch self {
        case .getBenefits:
            return "/api/rest/11976a60fdbf4f9813632829d8352ccd20/benefits"
        }
    }
}
