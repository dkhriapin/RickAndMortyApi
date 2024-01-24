//
//  Pageable.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 24/01/2024.
//

import Foundation

protocol Pageable: Decodable & Cacheable & SubitemCacheable {
    static var pagePath: String { get }
}

extension Character: Pageable {
    static var pagePath: String {
        return Constants.CHARACTER_PAGE_PATH
    }
}

extension Episode: Pageable {
    static var pagePath: String {
        return Constants.EPISODE_PAGE_PATH
    }
}

extension Location: Pageable {
    static var pagePath: String {
        return Constants.LOCATION_PAGE_PATH
    }
}
