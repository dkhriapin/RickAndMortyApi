//
//  CharacterCard.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 18/01/2024.
//

import SwiftUI



struct CharacterCard: View {
    @State var character: Character
    @Environment(\.colorScheme) var colorScheme
    
    private let coverPlaceholderBackgroundColor = Color(red: 0.8, green: 0.8, blue: 0.8)
    private let coverPlaceholderForegroundColor = Color.gray
   

    private let imageHeight = 300.0
    private let cornerRadius = 10.0
    
    var body: some View {
        let cardBackgroundColor = colorScheme == .dark ? Color(red: 0.4, green: 0.4, blue: 0.4) : Color(red: 0.8, green: 0.8, blue: 0.8)
        
        
        
        VStack(spacing: 0) {
            AsyncImage(url: character.image) { image in
                image.resizable()
                    .aspectRatio(1, contentMode: .fit)
            } placeholder: {
                ZStack{
                    Image(systemName: "photo")
                        .resizable()
                        .padding(10)
                        .aspectRatio(1, contentMode: .fit)
                        .background(coverPlaceholderBackgroundColor)
                        .foregroundColor(coverPlaceholderForegroundColor)
                }
            }
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    #if targetEnvironment(simulator)
                    Text(String(character.id))
                    #endif
                    Text(character.name)
                        .font(.title2)
                        .fontWeight(.bold)
                    StatusView(character: character)
                    Spacer()
                        .frame(maxHeight: 5)
                    Text("Last known location:")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    Text(character.location.name)
                    if let firstApperance = character.firstApperance {
                        Spacer()
                            .frame(maxHeight: 5)
                        Text("First seen in:")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                        Text(firstApperance)
                    }
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
    CharacterCard(character: Character.rick)
}
