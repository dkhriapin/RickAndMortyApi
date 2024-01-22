//
//  LocationsView.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 21/01/2024.
//

import SwiftUI

struct LocationsView: View {
    let apiService: RickAndMortyAPIService

    var body: some View {
        PaginatedView(apiService: apiService, filter: .constant(EmptyFilter()), cardView: { location in
            LocationCard(location: location)
        })
    }
}

#Preview {
    LocationsView(apiService: RickAndMortyAPIService())
}
