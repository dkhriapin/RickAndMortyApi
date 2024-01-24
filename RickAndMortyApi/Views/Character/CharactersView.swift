//
//  ContentView.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 18/01/2024.
//

import SwiftUI


struct CharactersView: View {
    @EnvironmentObject var apiService: RickAndMortyAPIService
    
    @State private var filter = CharacterFilter()
    
    var body: some View {
        FilteredPaginatedView(filter: $filter) { character in
            CharacterCard(character: character)
                .background(
                    NavigationLink("", destination: {
                        CharacterDetailsView(character: character)
                    })
                    .opacity(0)
                )
        } filterView: {
            CharacterFilterView(filter: $filter)
        }
    }
}

#Preview {
    CharactersView()
        .environmentObject(RickAndMortyAPIService())
}
