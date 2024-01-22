//
//  ContentView.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 18/01/2024.
//

import SwiftUI


struct CharactersView: View {
    let apiService: RickAndMortyAPIService
    
    @State private var filter = CharacterFilter()
    
    var body: some View {
        NavigationStackView {
            VStack {
                TextField("Name", text: $filter.name)
                    .textFieldStyle(.roundedBorder)
                Picker("Status", selection: $filter.status) {
                    Text("All").tag(Character.Status?.none)
                    ForEach(Character.Status.allCases) {
                        Text($0.rawValue.capitalized).tag($0 as Character.Status?)
                    }
                }
                .pickerStyle(.segmented)
            }
            .padding(.horizontal, 20)
            PaginatedView(apiService: apiService, filter: $filter, cardView: { character in
                CharacterCard(character: character)
                    .background(
                        NavigationLink("", destination: {
                            CharacterDetailsView(character: character)
                        })
                        .opacity(0)
                    )
            })
        }
    }
}

#Preview {
    CharactersView(apiService: RickAndMortyAPIService())
}
