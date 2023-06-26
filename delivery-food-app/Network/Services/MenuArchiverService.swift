//
//  MenuArchiverServiceImpl.swift
//  delivery-food-app
//
//  Created by Eugene on 21.03.23.
//

import Foundation

protocol MenuArchiver {
    func save(_ menu: [Product])
    func retrieve() -> [Product]
    func remove() -> [Product]
}

final class MenuArchiverServiceImpl: MenuArchiver {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let key = "Menu"
    
    func save(_ menu: [Product]) {
        do {
            let data = try encoder.encode(menu)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func retrieve() -> [Product] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        do {
            let array = try decoder.decode([Product].self, from: data)
            
            return array
        } catch {
            print(error)
        }
        
        return []
    }
    
    func remove() -> [Product] {
        UserDefaults.standard.removeObject(forKey: key)
        return []
    }
}
