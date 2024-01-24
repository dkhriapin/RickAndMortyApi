//
//  Location.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 21/01/2024.
//

import Foundation


struct Location: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [CharacterURL]
    let url: LocationURL
    let created: Date
    
    public var residentNames: String? {
        let chars = self.residents.compactMap{ CharacterCache.shared.getCachedItem(for: $0) }
        if chars.count == 0 {
            return nil
        }
        var cast = chars.reduce("") { $0 + "\($1.name), " }
        cast = String(cast.dropLast(2)) //Remove last ", "
        if chars.count != self.residents.count { //If not all self.residents were cached
            cast += ", ..."
        }
        return cast
    }
    
#if DEBUG
    static let EarthC137 = Location(id: 1,
                                    name: "Earth",
                                    type: "Planet",
                                    dimension: "Dimension C-137",
                                    residents: [CharacterURL(string: "https://rickandmortyapi.com/api/character/1"), CharacterURL(string: "https://rickandmortyapi.com/api/character/2")],
                                    url: LocationURL(string: "https://rickandmortyapi.com/api/location/1"),
                                    created: Date(timeIntervalSince1970: TimeInterval(1515608441))
    )
#endif
}

class LocationURL: APIURL {
    private var characterId: Int? {
        identifier(for: "location")
    }
    
    override var apiId: Int? {
        return characterId
    }
}

extension Location: Cacheable {
    static var cache: Cache<Location> {
        LocationCache.shared
    }
    var cacheKey: APIURL {
        self.url
    }
}

extension Location: SubitemCacheable {
    typealias Subitem = Character
    var subitems: [APIURL] {
        return self.residents
    }
}
