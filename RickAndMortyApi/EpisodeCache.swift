//
//  EpisodeCache.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 19/01/2024.
//

import Foundation

class EpisodeCache {
    static let shared = EpisodeCache()

    private var cache: [URL: Episode] = [:]
    private let cacheQueue = DispatchQueue(label: "com.example.EpisodeCacheQueue")

    private init() {}

    func getEpisode(for url: URL) -> Episode? {
        return cacheQueue.sync {
            return cache[url]
        }
    }

    func setEpisode(_ episode: Episode, for url: URL) {
        cacheQueue.async {
            self.cache[url] = episode
        }
    }
}
