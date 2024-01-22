//
//  PageResponse.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 19/01/2024.
//

import Foundation

struct PageResponse<T>: Decodable where T: Decodable   {
    struct Info: Decodable {
        let count: Int
        let pages: Int
        let next: URL?
        let prev: URL?
    }
    let info: Info?
    let results: [T]?
    let error: String?
    
    static func getEmptyPageResponse() -> PageResponse<T> {
        PageResponse(info: Info(count: 0, pages: 0, next: nil, prev: nil), results: [], error: nil)
    }
}

enum PageResponseError: Error, Equatable {
    case invalidURL
    case apiError(String)
    case genericError(String)
    
    public var localizedDescription: String {
        switch self {
        case .invalidURL: return "Invalid URL was built during API request!"
        case .apiError(let stringValue): return "API returned: \(stringValue)."
        case .genericError(let stringValue): return stringValue
        }
    }
    
    static func == (lhs: PageResponseError, rhs: PageResponseError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL): return true
        case (.apiError(let lhsString), .apiError(let rhsString)): return lhsString == rhsString
        case (.genericError(let lhsString), .genericError(let rhsString)): return lhsString == rhsString
        default: return false
        }
    }
}
