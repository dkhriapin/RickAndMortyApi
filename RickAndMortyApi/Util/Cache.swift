//
//  Cache.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 19/01/2024.
//

import Foundation

//MARK: - Cacheable

protocol Cacheable {
    var cacheKey: URL { get }
    static var cache: Cache<Self> { get }
}

//MARK: - Cache

class Cache<T: Cacheable> {
    private var cache: [URL: T] = [:]
    private let cacheQueue = DispatchQueue(label: "com.dkhriapin.RickAndMortyApi.CacheQueue")

    func getCachedItem(for url: URL) -> T? {
        return cacheQueue.sync {
            return cache[url]
        }
    }

    func setItem(_ item: T) {
        cacheQueue.async {
            self.cache[item.cacheKey] = item
        }
    }
}

class EpisodeCache: Cache<Episode> {
    static let shared = EpisodeCache()
}

class CharacterCache: Cache<Character> {
    static let shared = CharacterCache()
}

class LocationCache: Cache<Location> {
    static let shared = LocationCache()
}
