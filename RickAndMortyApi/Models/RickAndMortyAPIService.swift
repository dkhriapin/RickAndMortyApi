//
//  CharactersViewModel.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 18/01/2024.
//

import Foundation
import Combine


class RickAndMortyAPIService {
    private let BASE_URL = "https://rickandmortyapi.com/api/"
        
    func requestCharactersPage(_ page: Int) async -> Result<PageResponse<Character>, Error> {
        guard let url = buildURL(at: "character/", for: page) else {
            return .failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil))
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let page = try self.jsonDecoder.decode(PageResponse<Character>.self, from: data)
            
            for char in page.results {
                if CharacterCache.shared.getCachedItem(for: char.url) == nil {
                    CharacterCache.shared.setItem(char, for: char.url)
                }
            }
            
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
    
    func requestEpisodesPage(_ page: Int) async -> Result<PageResponse<Episode>, Error> {
        guard let url = buildURL(at: "episode/", for: page) else {
            return .failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil))
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let page = try self.jsonDecoder.decode(PageResponse<Episode>.self, from: data)
            
            for episode in page.results {
                if EpisodeCache.shared.getCachedItem(for: episode.url) == nil {
                    EpisodeCache.shared.setItem(episode, for: episode.url)
                }
            }
            
            await withTaskGroup(of: Void.self) { group in
                for episode in page.results {
                    group.addTask {
                        await self.fetchCharacters(for: episode)
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
                    if EpisodeCache.shared.getCachedItem(for: episodeURL) == nil {
                        do {
                            let (episodeData, _) = try await URLSession.shared.data(from: episodeURL)
                            let episode = try self.jsonDecoder.decode(Episode.self, from: episodeData)
                            EpisodeCache.shared.setItem(episode, for: episodeURL)
                        } catch {
                            // Handle error if needed
                            print("Error fetching episode data: \(error)")
                        }
                    }
                }
            }
        }
    }
    
    private func fetchCharacters(for episode: Episode) async {
        let charactersURLs = episode.characters
        
        await withTaskGroup(of: Void.self) { group in
            for charactersURL in charactersURLs {
                group.addTask {
                    if CharacterCache.shared.getCachedItem(for: charactersURL) == nil {
                        do {
                            let (characterData, _) = try await URLSession.shared.data(from: charactersURL)
                            let character = try self.jsonDecoder.decode(Character.self, from: characterData)
                            CharacterCache.shared.setItem(character, for: charactersURL)
                        } catch {
                            // Handle error if needed
                            print("Error fetching character data: \(error)")
                        }
                    }
                }
            }
        }
    }
    
    private func buildURL(at path: String, for page: Int) -> URL? {
        var components = URLComponents(string: BASE_URL + path)!
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
