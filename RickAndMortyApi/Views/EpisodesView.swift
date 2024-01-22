//
//  EpisodesView.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 19/01/2024.
//

import SwiftUI


struct EpisodesView: View {
    let apiService: RickAndMortyAPIService

    var body: some View {
        PaginatedView(apiService: apiService, filter: .constant(EmptyFilter()), cardView: { episode in
            EpisodeCard(episode: episode)
        })
    }
}

#Preview {
    EpisodesView(apiService: RickAndMortyAPIService())
}
