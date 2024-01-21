//
//  CharacterDetailsView.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 21/01/2024.
//

import SwiftUI

struct CharacterDetailsView: View {
    @State var character: Character

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                AsyncImage(url: character.image) { image in
                    image.resizable()
                        .aspectRatio(1, contentMode: .fit)
                } placeholder: {
                    AsyncImagePlaceholder()
                }
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(character.name)
                            .font(.title2)
                            .fontWeight(.semibold)
                        StatusView(character: character)
                        Spacer()
                            .frame(maxHeight: 5)
                        Text("Last known location:")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Text(character.location.name)
                            .font(.body)
                        Spacer()
                            .frame(maxHeight: 5)
                        Text("Seen in:")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        ForEach(character.episode, id: \.self) { episodeURL in
                            if let episode = EpisodeCache.shared.getCachedItem(for: episodeURL) {
                                Text("\(episode.episodeCode): \(episode.name)")
                            } else {
                                Text("Episode #\(episodeURL.episodeId!)")
                            }
                        }
                    }
                    .padding(10)
                    Spacer()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(character.name)
    }
    
}

#Preview {
    let char = Character.Rick
    EpisodeCache.shared.setItem(Episode.pilot)
    
    return NavigationStackView {
        CharacterDetailsView(character: char)
    }
}

#Preview {
    NavigationStackView {
        CharacterDetailsView(character: Character.StanLeeRick)
    }
}
