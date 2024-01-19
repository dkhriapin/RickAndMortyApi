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
                return "\(character.status.rawValue.capitalized) - \(character.species)"
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
    StatusView(character: Character.rick)
}
