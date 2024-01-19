//
//  CharactersViewModel.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 18/01/2024.
//

import Foundation
import Combine


class CharactersModel {
    private let BASE_URL = "https://rickandmortyapi.com/api/"
    
    func requestPage(_ page: Int) async -> Result<PageResponse<Character>, Error> {
        guard let url = buildURL(forPage: page) else {
            return .failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil))
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let page = try self.jsonDecoder.decode(PageResponse<Character>.self, from: data)
            
            await withTaskGroup(of: Void.self) { group in
                for character in page.results {
                    group.addTask {
                        await self.fetchEpisodes(for: character)
                    }
                }
            }
            
            return .success(page)
        } catch(let error) {
            return .failure(error)
        }
    }
    
    private func fetchEpisodes(for character: Character) async {
        let episodeURLs = character.episode
        
        await withTaskGroup(of: Void.self) { group in
            for episodeURL in episodeURLs {
                group.addTask {
                    if EpisodeCache.shared.getEpisode(for: episodeURL) == nil {
                        do {
                            let (episodeData, _) = try await URLSession.shared.data(from: episodeURL)
                            let episode = try self.jsonDecoder.decode(Episode.self, from: episodeData)
                            EpisodeCache.shared.setEpisode(episode, for: episodeURL)
                        } catch {
                            // Handle error if needed
                            print("Error fetching episode data: \(error)")
                        }
                    }
                }
            }
        }
    }
    
    private func buildURL(forPage page: Int) -> URL? {
        var components = URLComponents(string: BASE_URL + "character/")!
        components.queryItems = [URLQueryItem(name: "page", value: "\(page)")]
        return components.url
    }
    
    private lazy var jsonDecoder = {
        let jsonDecoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
}
