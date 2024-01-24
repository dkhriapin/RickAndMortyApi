//
//  EpisodesView.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 19/01/2024.
//

import SwiftUI


struct EpisodesView: View {
    @EnvironmentObject var apiService: RickAndMortyAPIService
    
    @State private var filter = EpisodeFilter()
    
    var body: some View {
        FilteredPaginatedView(filter: $filter) { episode in
            EpisodeCard(episode: episode)
        } filterView: {
            EpisodeFilterView(filter: $filter)
        }
    }
}

#Preview {
    EpisodesView()
        .environmentObject(RickAndMortyAPIService())
}
