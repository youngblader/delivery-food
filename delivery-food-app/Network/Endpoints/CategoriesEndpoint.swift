//
//  CategoriesEndpoint.swift
//  delivery-food-app
//
//  Created by Eugene on 13.04.23.
//

import Foundation

enum CategoriesEndpoint {
    case getCategories
}

extension CategoriesEndpoint: Endpoint {
    var parameters: [URLQueryItem] {
        switch self {
        case .getCategories:
            return []
        }
    }

    var method: NetworkMethod {
        switch self {
        case .getCategories:
            return .get
        }
    }
    
    var headers: [String : String]? {
        let accessToken = ""
        switch self {
        case .getCategories:
            return [
                "Authorization": "Bearer \(accessToken)",
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .getCategories:
            return nil
        }
    }
    
    var path: String {
        switch self {
        case .getCategories:
            return "/api/rest/14b2c2ad2d3053ae647231bf4b4d083021/products-categories"
        }
    }
}
