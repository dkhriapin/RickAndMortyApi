//
//  CharactersViewModel.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 18/01/2024.
//

import Foundation
import Combine

protocol Pageable: Decodable & Cacheable & SubitemCacheable {
    static var pagePath: String { get }
}

extension Character: Pageable {
    static var pagePath: String {
        return "character/"
    }
}

extension Episode: Pageable {
    static var pagePath: String {
        return "episode/"
    }
}

extension Location: Pageable {
    static var pagePath: String {
        return "location/"
    }
}

class RickAndMortyAPIService {
    private let BASE_URL = "https://rickandmortyapi.com/api/"
    
    func requestPage<T: Pageable>(_ page: Int) async -> Result<PageResponse<T>, Error> {
        return await requestPage(page, at: T.pagePath)
    }
        
    private func requestPage<T: Decodable & Cacheable & SubitemCacheable>(_ page: Int, at path: String) async -> Result<PageResponse<T>, Error> {
        guard let url = buildURL(at: path, for: page) else {
            return .failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil))
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let page = try self.jsonDecoder.decode(PageResponse<T>.self, from: data)
            
            //Cache items in page results
            let cache = T.cache
            for item in page.results {
                if cache.getCachedItem(for: item.cacheKey) == nil {
                    cache.setItem(item)
                }
            }
            //Cache subitems of each item in page results
            await withTaskGroup(of: Void.self) { group in
                for item in page.results {
                    group.addTask {
                        await self.cacheRelatedSubitems(for: item)
                    }
                }
            }
            
            return .success(page)
        } catch(let error) {
            return .failure(error)
        }
        
    }
    
    private func cacheRelatedSubitems<T: SubitemCacheable>(for item: T) async {
        let subitems = item.subitems
        let cache = item.subitemCache
        
        await withTaskGroup(of: Void.self) { group in
            for subitemURL in subitems {
                group.addTask {
                    if cache.getCachedItem(for: subitemURL) == nil {
                        do {
                            let (data, _) = try await URLSession.shared.data(from: subitemURL)
                            let subitem = try self.jsonDecoder.decode(T.Subitem.self, from: data)
                            cache.setItem(subitem)
                        } catch {
                            // No need to handle error here. We can't fetch subitem to cache it - will try another time.
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
