//
//  EpisodeCard.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 19/01/2024.
//

import SwiftUI


struct EpisodeCard: View {
    @State var episode: Episode
    @Environment(\.colorScheme) var colorScheme
       
    private let cornerRadius = 10.0
    
    var body: some View {
        let cardBackgroundColor = colorScheme == .dark ? Color(red: 0.4, green: 0.4, blue: 0.4) : Color(red: 0.8, green: 0.8, blue: 0.8)
        
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("\(episode.episodeCode): \(episode.name)")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                        .frame(maxHeight: 5)
                    Text("Air date:")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    Text(episode.airDate)
                    Text("Staring:")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    Text(episode.cast)
                }
                .padding(10)
                Spacer()
            }
            .background(cardBackgroundColor)
        }
        .cornerRadius(cornerRadius)
    }
}

#Preview {
    CharacterCache.shared.setItem(Character.Rick)
    return EpisodeCard(episode: Episode.pilot)
        .padding()
}
