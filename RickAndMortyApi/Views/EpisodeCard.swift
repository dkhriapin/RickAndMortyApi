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
    
    private let coverPlaceholderBackgroundColor = Color(red: 0.8, green: 0.8, blue: 0.8)
    private let coverPlaceholderForegroundColor = Color.gray
   

    private let imageHeight = 300.0
    private let cornerRadius = 10.0
    
    var body: some View {
        let cardBackgroundColor = colorScheme == .dark ? Color(red: 0.4, green: 0.4, blue: 0.4) : Color(red: 0.8, green: 0.8, blue: 0.8)
        
        
        
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    #if targetEnvironment(simulator)
                    Text(String(episode.id))
                    #endif
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
        .padding()
        
    }
}

#Preview {
    EpisodeCard(episode: Episode.pilot)
}
