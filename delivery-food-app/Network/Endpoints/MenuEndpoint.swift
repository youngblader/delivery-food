//
//  MenuEndpoint.swift
//  delivery-food-app
//
//  Created by Eugene on 13.04.23.
//

import Foundation

enum MenuEndpoint {
    case getMenu
}

extension MenuEndpoint: Endpoint {
    var method: NetworkMethod {
        switch self {
        case .getMenu:
            return .get
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .getMenu:
            return nil
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getMenu:
            return []
        }
    }
    
    var headers: [String : String]? {
        let accessToken = ""
        switch self {
        case .getMenu:
            return [
                "Authorization": "Bearer \(accessToken)",
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    var path: String {
        switch self {
        case .getMenu:
            return "/api/rest/d07399df2361ee75646f27237fec7f413/menu"
        }
    }
}
