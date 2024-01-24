//
//  EpisodeFilterView.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 24/01/2024.
//

import SwiftUI

struct EpisodeFilterView: View {
    @Binding var filter: EpisodeFilter
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0) {
            Text("Name:")
            TextField("Name", text: $filter.name)
                .textFieldStyle(.roundedBorder)
                .showClearButton($filter.name)
            Text("Episode:")
            TextField("Episode", text: $filter.episode)
                .textFieldStyle(.roundedBorder)
                .showClearButton($filter.episode)
            Spacer()
        }
        .padding(20)
    }
}

#Preview {
    EpisodeFilterView(filter: .constant(EpisodeFilter()))
}

