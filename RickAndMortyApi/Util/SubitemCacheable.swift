//
//  SubitemCacheable.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 20/01/2024.
//

import Foundation


protocol SubitemCacheable {
    associatedtype Subitem: Cacheable, Decodable, Batchable
    var subitems: [APIURL] { get }
}
