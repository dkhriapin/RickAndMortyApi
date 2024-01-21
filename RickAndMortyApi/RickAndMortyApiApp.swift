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
                LocationsView(apiService: apiService)
                    .tabItem { Label("Locations", systemImage: "globe") }
                EpisodesView(apiService: apiService)
                    .tabItem { Label("Episodes", systemImage: "film") }
            }
        }
    }
}
