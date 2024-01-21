//
//  Episode.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 19/01/2024.
//

import Foundation


struct Episode: Decodable, Identifiable {
    let id: Int
    let name: String
    let airDate: String
    let episodeCode: String
    let characters: [CharacterURL]
    let url: EpisodeURL
    let created: Date
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case airDate = "air_date"
        case episodeCode = "episode"
        case characters
        case url
        case created
    }
    
    public var cast: String {
        let chars = self.characters.compactMap{ CharacterCache.shared.getCachedItem(for: $0) }
        var cast = chars.reduce("") { $0 + "\($1.name), " }
        cast = String(cast.dropLast(2)) //Remove last ", "
        if chars.count != self.characters.count { //If not all self.characters were cached
            cast = cast == "" ? "..." : cast + ", ..."
        }
        return cast
    }
    
#if DEBUG
    
    static let pilot = Episode(id: 1,
                               name: "Pilot",
                               airDate: "December 2, 2013",
                               episodeCode: "S01E01",
                               characters: [URL(string: "https://rickandmortyapi.com/api/character/1")!, URL(string: "https://rickandmortyapi.com/api/character/2")!],
                               url: URL(string: "https://rickandmortyapi.com/api/episode/1")!,
                               created: Date(timeIntervalSince1970: TimeInterval(1515608441))
    )
    
#endif
}

typealias EpisodeURL = URL

extension EpisodeURL {
    var episodeId: Int? {
        identifier(for: "episode")
    }
}

extension Episode: Cacheable {
    static var cache: Cache<Episode> {
        EpisodeCache.shared
    }
    var cacheKey: URL {
        self.url
    }
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
