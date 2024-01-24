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
    
    init() {
        UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance.init(idiom: .unspecified)
    }
    
    var body: some Scene {
        WindowGroup {
            TabView {
                CharactersView()
                    .tabItem { Label("Characters", systemImage: "person.fill") }
                LocationsView()
                    .tabItem { Label("Locations", systemImage: "globe") }
                EpisodesView()
                    .tabItem { Label("Episodes", systemImage: "film") }
            }
            .environmentObject(apiService)
        }
    }
}
