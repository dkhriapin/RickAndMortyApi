//
//  EpisodeFilter.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 24/01/2024.
//

import Foundation


struct EpisodeFilter: APIFilter {
    var name: String = ""
    var episode: String = ""
    
    var queryItems: [URLQueryItem] {
        var items = [URLQueryItem]()
        if !self.name.isEmpty {
            items.append(URLQueryItem(name: "name", value: name))
        }
        if !self.episode.isEmpty {
            items.append(URLQueryItem(name: "episode", value: episode))
        }
        return items
    }
    
    static func == (lhs: EpisodeFilter, rhs: EpisodeFilter) -> Bool {
        return lhs.name == rhs.name
        && lhs.episode == rhs.episode
    }
}
