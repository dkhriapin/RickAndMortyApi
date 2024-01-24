//
//  Batchable.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 24/01/2024.
//

import Foundation

protocol Batchable {
    static var batchPath: String { get }
}

extension Character: Batchable {
    static var batchPath: String {
        return Constants.CHARACTER_BATCH_PATH
    }
}

extension Episode: Batchable {
    static var batchPath: String {
        return Constants.EPISODE_BATCH_PATH
    }
}

extension Location: Batchable {
    static var batchPath: String {
        return Constants.LOCATION_BATCH_PATH
    }
}
