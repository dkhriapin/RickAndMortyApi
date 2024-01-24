//
//  LocationFilterView.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 24/01/2024.
//

import SwiftUI

struct LocationFilterView: View {
    @Binding var filter: LocationFilter
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0) {
            Text("Name:")
            TextField("Name", text: $filter.name)
                .textFieldStyle(.roundedBorder)
                .showClearButton($filter.name)
            Text("Type:")
            TextField("Type", text: $filter.type)
                .textFieldStyle(.roundedBorder)
                .showClearButton($filter.type)
            Text("Dimension:")
            TextField("Dimension", text: $filter.dimension)
                .textFieldStyle(.roundedBorder)
                .showClearButton($filter.dimension)
            Spacer()
        }
        .padding(20)
    }
}

#Preview {
    LocationFilterView(filter: .constant(LocationFilter()))
}
