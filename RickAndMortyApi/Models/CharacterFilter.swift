//
//  CharacterFilter.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 22/01/2024.
//

import Foundation


struct CharacterFilter: APIFilter {
    var name: String = ""
    var status: Character.Status?
    
    var queryItems: [URLQueryItem] {
        var items = [URLQueryItem]()
        if self.name != "" {
            items.append(URLQueryItem(name: "name", value: name))
        }
        if let status = self.status {
            items.append(URLQueryItem(name: "status", value: status.rawValue))
        }
        return items
    }
    
    static func == (lhs: CharacterFilter, rhs: CharacterFilter) -> Bool {
        return lhs.name == rhs.name && lhs.status == rhs.status
    }
}
