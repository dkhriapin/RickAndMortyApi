//
//  StatusView.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 19/01/2024.
//

import SwiftUI


struct StatusView: View {
    @State var character: Character
    
    var body: some View {
        var dotColor: Color? {
            switch character.status {
            case .alive:
                return .green
            case .dead:
                return .red
            case .unknown:
                return nil
            }
        }
        var statusText: String {
            switch character.status {
            case .alive, .dead:
                return "\(character.status.rawValue.capitalized) - \(character.species.capitalized)"
            case .unknown:
                return character.species.capitalized
            }
        }
        HStack {
            if let dotColor = dotColor {
                Circle()
                    .fill(dotColor)
                    .frame(height: 10)
            }
            Text(statusText)
                .font(.subheadline)
        }
    }
    
}

#Preview {
    VStack(alignment: .leading, spacing: 10.0) {
        StatusView(character: Character.Rick)
        Spacer(minLength: 10)
        StatusView(character: Character.StanLeeRick)
        Spacer(minLength: 10)
        StatusView(character: Character.AlanRails)
    }
    .frame(width: 350, height: 50)
}
