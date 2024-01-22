//
//  CharacterFilterView.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 22/01/2024.
//

import SwiftUI


struct CharacterFilterView: View {
    @Binding var filter: CharacterFilter

    var body: some View {
        VStack(spacing: 15.0) {
            TextField("Name", text: $filter.name)
                .textFieldStyle(.roundedBorder)
                .showClearButton($filter.name)
            Picker("Status", selection: $filter.status) {
                Text("All").tag(Character.Status?.none)
                ForEach(Character.Status.allCases) {
                    Text($0.rawValue.capitalized).tag($0 as Character.Status?)
                }
            }
            .pickerStyle(.segmented)
            Spacer()
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 20)
    }
}

#Preview {
    CharacterFilterView(filter: .constant(CharacterFilter()))
}

