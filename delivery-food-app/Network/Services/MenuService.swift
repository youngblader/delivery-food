//
//  MenuService.swift
//  delivery-food-app
//
//  Created by Eugene on 28.02.23.
//

import Foundation

protocol MenuService {
    func fetchMenu() async throws -> [Menu]
    func fetchCategories() async throws -> [Category]
}

final class MenuServiceImpl: MenuService, API {
    //MARK: JSON data
//    func loadMenu() -> [Menu] {
//        let jsonLoaderService = JsonLoaderService()
//
//        return jsonLoaderService.loadMenu(filename: "menu") ?? []
//    }
    
    func fetchMenu() async throws -> [Menu] {
        return try await request(endpoint: MenuEndpoint.getMenu, responseModel: MenuResponse.self).menu
    }
    
    func fetchCategories() async throws -> [Category] {
        return try await request(endpoint: CategoriesEndpoint.getCategories, responseModel: CategoriesResponse.self).categories
    }
}
