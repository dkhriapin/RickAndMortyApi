//
//  SubitemCacheable.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 20/01/2024.
//

import Foundation


protocol SubitemCacheable {
    associatedtype Subitem: Cacheable, Decodable
    var subitems: [URL] { get }
    var subitemCache: Cache<Subitem> { get }
}

extension Episode: SubitemCacheable {
    typealias Subitem = Character
    
    var subitems: [URL] {
        return self.characters
    }
    
    var subitemCache: Cache<Subitem> {
        return CharacterCache.shared
    }
}

extension Character: SubitemCacheable {
    typealias Subitem = Episode
    
    var subitems: [URL] {
        return self.episode
    }
    
    var subitemCache: Cache<Subitem> {
        return EpisodeCache.shared
    }
}
