//
//  Character.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 18/01/2024.
//

import Foundation


struct Character: Decodable, Identifiable {
    enum Status: String, Decodable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown
    }
    
    enum Gender: String, Decodable {
        case female = "Female"
        case male = "Male"
        case genderless = "Genderless"
        case unknown
    }
    
    struct Location: Decodable {
        let name: String
        let url: URL?
        
        private enum CodingKeys: String, CodingKey {
            case name
            case url
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            name = try container.decode(String.self, forKey: .name)
            
            // Decode the URL, treating an empty string as a valid value
            if let urlString = try? container.decode(String.self, forKey: .url) {
                url = URL(string: urlString)
            } else {
                url = nil
            }
        }
        
        init(name: String, url: URL?) {
            self.name = name
            self.url = url
        }
    }
    
    let id: Int
    let name: String
    let status: Status
    let species: String
    let type: String
    let gender: Gender
    let origin: Location
    let location: Location
    let image: URL
    let episode: [EpisodeURL]
    let url: CharacterURL
    let created: Date
    
    public var firstApperance: String? {
        guard let firstEpisodeURL = episode.first else { return nil }
        guard let firstEpisode = EpisodeCache.shared.getCachedItem(for: firstEpisodeURL) else { return firstEpisodeURL.episodeId.map { "Episode #\($0)" } }
        return firstEpisode.name
    }
    
#if DEBUG
    
    static let Rick = Character(id: 1,
                                name: "Rick Sanchez",
                                status: .alive,
                                species: "Human",
                                type: "",
                                gender: .male,
                                origin: Location(name: "Earth", url: URL(string:"https://rickandmortyapi.com/api/location/1")),
                                location: Location(name: "Earth", url: URL(string:"https://rickandmortyapi.com/api/location/20")),
                                image: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!,
                                episode: [URL(string: "https://rickandmortyapi.com/api/episode/1")!, URL(string: "https://rickandmortyapi.com/api/episode/2")!],
                                url: URL(string: "https://rickandmortyapi.com/api/character/1")!,
                                created: Date(timeIntervalSince1970: TimeInterval(1515608441))
    )
    
    static let StanLeeRick = Character(id: 810,
                                       name: "Stan Lee Rick",
                                       status: .unknown,
                                       species: "Human",
                                       type: "",
                                       gender: .male,
                                       origin: Location(name: "unknown", url: nil),
                                       location: Location(name: "Citadel of Ricks", url: URL(string: "https://rickandmortyapi.com/api/location/3")!),
                                       image: URL(string: "https://rickandmortyapi.com/api/character/avatar/810.jpeg")!,
                                       episode: [URL(string: "https://rickandmortyapi.com/api/episode/51")!],
                                       url: URL(string: "https://rickandmortyapi.com/api/character/810")!,
                                       created: Date(timeIntervalSince1970: TimeInterval(1515608441))
    )
    
#endif
}

typealias CharacterURL = URL

extension CharacterURL: IdentifiableURL {
    var characterId: Int? {
        identifier(for: "character")
    }
}

extension Character: Cacheable {
    static var cache: Cache<Character> {
        CharacterCache.shared
    }
    var cacheKey: URL {
        self.url
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
