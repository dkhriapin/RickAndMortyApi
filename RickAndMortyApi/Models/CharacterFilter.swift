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
    var species: String = ""
    var type: String = ""
    var gender: Character.Gender?
    
    var queryItems: [URLQueryItem] {
        var items = [URLQueryItem]()
        if !self.name.isEmpty {
            items.append(URLQueryItem(name: "name", value: name))
        }
        if let status = self.status {
            items.append(URLQueryItem(name: "status", value: status.rawValue))
        }
        if !self.species.isEmpty {
            items.append(URLQueryItem(name: "species", value: species))
        }
        if !self.type.isEmpty {
            items.append(URLQueryItem(name: "type", value: type))
        }
        if let gender = self.gender {
            items.append(URLQueryItem(name: "gender", value: gender.rawValue))
        }
        return items
    }
    
    static func == (lhs: CharacterFilter, rhs: CharacterFilter) -> Bool {
        return lhs.name == rhs.name 
        && lhs.status == rhs.status
        && lhs.species == rhs.species
        && lhs.type == rhs.type
        && lhs.gender == rhs.gender
    }
}
