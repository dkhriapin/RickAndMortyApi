//
//  LocationFilter.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 24/01/2024.
//

import Foundation

struct LocationFilter: APIFilter {
    var name: String = ""
    var type: String = ""
    var dimension: String = ""
    
    var queryItems: [URLQueryItem] {
        var items = [URLQueryItem]()
        if !self.name.isEmpty {
            items.append(URLQueryItem(name: "name", value: name))
        }
        if !self.type.isEmpty {
            items.append(URLQueryItem(name: "type", value: type))
        }
        if !self.dimension.isEmpty {
            items.append(URLQueryItem(name: "dimension", value: dimension))
        }
        return items
    }
    
    static func == (lhs: LocationFilter, rhs: LocationFilter) -> Bool {
        return lhs.name == rhs.name
        && lhs.type == rhs.type
        && lhs.dimension == rhs.dimension
    }
}
