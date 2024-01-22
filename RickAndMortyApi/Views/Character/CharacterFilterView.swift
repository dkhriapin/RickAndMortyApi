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
        VStack(alignment: .leading, spacing: 10.0) {
            Text("Name:")
            TextField("Name", text: $filter.name)
                .textFieldStyle(.roundedBorder)
                .showClearButton($filter.name)
            Text("Status:")
            Picker("Status", selection: $filter.status) {
                Text("All").tag(Character.Status?.none)
                ForEach(Character.Status.allCases) {
                    Text($0.rawValue.capitalized).tag($0 as Character.Status?)
                }
            }
            .pickerStyle(.segmented)
            Text("Species:")
            TextField("Species", text: $filter.species)
                .textFieldStyle(.roundedBorder)
                .showClearButton($filter.species)
            Text("Type:")
            TextField("Type", text: $filter.type)
                .textFieldStyle(.roundedBorder)
                .showClearButton($filter.type)
            Text("Gender:")
            Picker("Gender", selection: $filter.gender) {
                Text("All").tag(Character.Gender?.none)
                ForEach(Character.Gender.allCases) {
                    Text($0.rawValue.capitalized).tag($0 as Character.Gender?)
                }
            }
            .pickerStyle(.segmented)
            Spacer()
        }
        .padding(20)
    }
}

#Preview {
    CharacterFilterView(filter: .constant(CharacterFilter()))
}

