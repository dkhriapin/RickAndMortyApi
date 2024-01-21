//
//  LocationCard.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 21/01/2024.
//

import SwiftUI

struct LocationCard: View {
    @State var location: Location
    @Environment(\.colorScheme) var colorScheme
    
    private let cornerRadius = 10.0
    
    var body: some View {
        let cardBackgroundColor = colorScheme == .dark ? Color(red: 0.4, green: 0.4, blue: 0.4) : Color(red: 0.8, green: 0.8, blue: 0.8)
        
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(location.name)
                        .font(.title2)
                        .fontWeight(.bold)
                    Text(location.type.capitalized)
                        .font(.subheadline)
                    Spacer()
                        .frame(maxHeight: 5)
                    if location.dimension != "" {
                        Text("Dimension:")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                        Text(location.dimension.capitalized)
                    }
                    if let residents = location.residentNames
                    {
                        Text("Residents:")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                        Text(residents)
                    }
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
    return LocationCard(location: Location.EarthC137).padding()
}
