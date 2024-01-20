//
//  ContentView.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 18/01/2024.
//

import SwiftUI


struct CharactersView: View {
    let apiService: RickAndMortyAPIService

    var body: some View {
        PaginatedView(apiService: apiService, cardView: { character in
            CharacterCard(character: character)
        })
    }
}

#Preview {
    CharactersView(apiService: RickAndMortyAPIService())
}
