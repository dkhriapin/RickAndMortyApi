//
//  TextField+ShowClearButton.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 22/01/2024.
//

import SwiftUI

struct TextFieldClearButton: ViewModifier {
    @Binding var text: String
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if !text.isEmpty {
                    HStack {
                        Spacer()
                        Button {
                            text = ""
                        } label: {
                            Image(systemName: "multiply.circle.fill")
                        }
                        .foregroundColor(.secondary)
                        .padding(.trailing, 4)
                    }
                }
            }
    }
}

extension View {
    func showClearButton(_ text: Binding<String>) -> some View {
        self.modifier(TextFieldClearButton(text: text))
    }
}

#Preview {
    @State var text = "text"
    return TextField("", text: $text)
        .textFieldStyle(.roundedBorder)
        .showClearButton($text)
}
