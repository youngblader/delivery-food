//
//  JsonLoaderService.swift
//  delivery-food-app
//
//  Created by Eugene on 18.03.23.
//

import Foundation

protocol JsonLoaderService {
    func loadMenu(filename: String) -> [Menu]?
}

final class JsonLoaderServiceImpl: JsonLoaderService {
    func loadMenu(filename: String) -> [Menu]? {
        if let url = Bundle.main.url(forResource: filename, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let jsonData = try JSONDecoder().decode(MenuResponse.self, from: data)

                return jsonData.menu
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
