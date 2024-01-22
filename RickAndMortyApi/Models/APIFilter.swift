//
//  APIFilter.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 22/01/2024.
//

import Foundation

protocol APIFilter: Equatable {
    var queryItems: [URLQueryItem] { get }
}

struct EmptyFilter: APIFilter {
    var queryItems: [URLQueryItem] {
        return []
    }
  
    static func == (lhs: EmptyFilter, rhs: EmptyFilter) -> Bool {
        return true
    }
}
