//
//  Cache.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 19/01/2024.
//

import Foundation

class Cache<T> {
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
