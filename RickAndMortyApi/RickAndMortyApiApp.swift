//
//  RickAndMortyApiApp.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 18/01/2024.
//

import SwiftUI

@main
struct RickAndMortyApiApp: App {
    let apiService = RickAndMortyAPIService()
    var body: some Scene {
        WindowGroup {
            TabView {
                CharactersView(apiService: apiService)
                    .tabItem { Label("Characters", systemImage: "person.fill") }
                EpisodesView(apiService: apiService)
                    .tabItem { Label("Episodes", systemImage: "film") }
            }
        }
    }
}
