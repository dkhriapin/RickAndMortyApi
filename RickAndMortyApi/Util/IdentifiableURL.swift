//
//  IdentifiableURL.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 21/01/2024.
//

import Foundation


protocol IdentifiableURL {
    func identifier(for key: String) -> Int?
}

extension IdentifiableURL where Self == URL {
    func identifier(for key: String) -> Int? {
        guard let index = self.pathComponents.firstIndex(of: key), index + 1 < self.pathComponents.count else { return nil }
        let identifierString = self.pathComponents[index + 1]
        return Int(identifierString)
    }
}
