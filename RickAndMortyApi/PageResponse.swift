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
    let info: Info
    let results: [T]
}
