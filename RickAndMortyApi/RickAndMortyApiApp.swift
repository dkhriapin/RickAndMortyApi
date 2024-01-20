//
//  RickAndMortyApiApp.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 18/01/2024.
//

import SwiftUI

@main
struct RickAndMortyApiApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                CharactersView()
                    .tabItem { Label("Characters", systemImage: "person.fill") }
                EpisodesView()
                    .tabItem { Label("Episodes", systemImage: "film") }
            }
        }
    }
}
