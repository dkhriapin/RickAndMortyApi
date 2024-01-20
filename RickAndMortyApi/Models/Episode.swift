//
//  Episode.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 19/01/2024.
//

import Foundation


struct Episode: Decodable {
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
        let names = characters.reduce("") { partialResult, characterURL in
            if let char = CharacterCache.shared.getCachedItem(for: characterURL) {
                return partialResult + "\(char.name), "
            } else {
                return partialResult + "\(characterURL.absoluteString), "
            }
        }
        return String(names.dropLast(2))
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
