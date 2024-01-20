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
}

extension Episode: Cacheable {
    var cacheKey: URL { return self.url }
}

extension Character: Cacheable {
    var cacheKey: URL { return self.url }
}

extension Cacheable {
    static var cache: Cache<Self> {
        return Cache<Self>()
    }
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

    func setItem(_ item: T, for url: URL) {
        cacheQueue.async {
            self.cache[url] = item
        }
    }
}

class EpisodeCache: Cache<Episode> {
    static let shared = EpisodeCache()
}

class CharacterCache: Cache<Character> {
    static let shared = CharacterCache()
}
