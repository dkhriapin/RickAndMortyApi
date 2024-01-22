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
    @State private var showingFilterSheet = false
    
    var body: some View {
        NavigationStackView {
            PaginatedView(apiService: apiService, filter: $filter, cardView: { character in
                CharacterCard(character: character)
                    .background(
                        NavigationLink("", destination: {
                            CharacterDetailsView(character: character)
                        })
                        .opacity(0)
                    )
            })
            .toolbar {
                Button {
                    showingFilterSheet.toggle()
                } label: {
                    Image(systemName: "line.3.horizontal.decrease")
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .halfSheet(showSheet: $showingFilterSheet, sheetView: {
                CharacterFilterView(filter: $filter)
            })
        }
    }
}

#Preview {
    CharactersView(apiService: RickAndMortyAPIService())
}
