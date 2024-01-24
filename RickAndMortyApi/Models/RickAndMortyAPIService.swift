//
//  CharactersViewModel.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 18/01/2024.
//

import Foundation
import Combine


class RickAndMortyAPIService {
    
    func requestPage<T: Pageable>(_ page: Int, with filter: any APIFilter) async -> Result<PageResponse<T>, Error> {
        return await requestPage(page, at: T.pagePath, with: filter)
    }
        
    private func requestPage<T: Decodable & Cacheable & SubitemCacheable>(_ page: Int, at path: String, with filter: any APIFilter) async -> Result<PageResponse<T>, Error> {
        guard let url = buildURL(at: path, for: page, with: filter) else {
            return .failure(PageResponseError.invalidURL)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let page = try self.jsonDecoder.decode(PageResponse<T>.self, from: data)
            
            if let errorText = page.error {
                return .failure(PageResponseError.apiError(errorText))
            }
                        
            guard let items = page.results else {
                //Valid response but no results - return empty PageResponse
                //Can parse page.error here for details.
                return .success(PageResponse<T>.getEmptyPageResponse())
                
            }
            
            //Cache items in page results
            let cache = T.cache
            for item in items {
                if cache.getCachedItem(for: item.cacheKey) == nil {
                    cache.setItem(item)
                }
            }
            //Cache subitems of each item in page results
            for item in items {
                await self.cacheRelatedSubitems(for: item) //Subitems are fetched sequentially in order to prevent multiple requests that include same subitems
            }
            
            return .success(page)
        } catch(let error) {
            return .failure(error)
        }
        
    }
    
    private func cacheRelatedSubitems<T: SubitemCacheable>(for item: T) async {
        let cache = T.Subitem.cache
        
        var batchIds = [Int]()
        for subitemURL in item.subitems {
            if cache.getCachedItem(for: subitemURL) == nil, let id = subitemURL.apiId {
                batchIds.append(id)
            }
        }
        guard !batchIds.isEmpty else { return }
        
        guard let url = buildBatchURL(at: T.Subitem.batchPath, for: batchIds) else {
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let subitems = try self.jsonDecoder.decode([T.Subitem].self, from: data)
            for subitem in subitems {
                cache.setItem(subitem)
            }
        } catch {
            // No need to handle error here. We can't fetch subitem to cache it - will try another time.
        }
    }
    
    private func buildBatchURL(at path: String, for ids: [Int]) -> URL? {
        let components = URLComponents(string: Constants.BASE_URL + path)!
        let idsComponent = ids.map{ String($0) }.joined(separator: ",")
        return components.url?.appendingPathComponent(idsComponent)
    }
    
    private func buildURL(at path: String, for page: Int, with filter: any APIFilter) -> URL? {
        var components = URLComponents(string: Constants.BASE_URL + path)!
        var queryItems = filter.queryItems
        queryItems.append(URLQueryItem(name: "page", value: "\(page)"))
        components.queryItems = queryItems
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
