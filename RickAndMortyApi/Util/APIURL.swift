//
//  APIURL.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 21/01/2024.
//

import Foundation

class APIURL: Decodable {
    private let url: URL?
    
    init(string: String) {
        url = URL(string: string)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        url = try container.decode(URL.self)
    }
    
    func identifier(for key: String) -> Int? {
        guard let pathComponents = self.url?.pathComponents,
                let index = pathComponents.firstIndex(of: key),
              index + 1 < pathComponents.count else {
            return nil
        }
        let identifierString = pathComponents[index + 1]
        return Int(identifierString)
    }
    
    var apiId: Int? {
        return nil
    }
}

extension APIURL: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.url)
    }
}

extension APIURL: Equatable {
    static func == (lhs: APIURL, rhs: APIURL) -> Bool {
        return lhs.url == rhs.url
    }
}
