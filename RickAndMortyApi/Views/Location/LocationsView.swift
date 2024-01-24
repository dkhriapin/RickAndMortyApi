//
//  LocationsView.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 21/01/2024.
//

import SwiftUI


struct LocationsView: View {
    @EnvironmentObject var apiService: RickAndMortyAPIService
    
    @State private var filter = LocationFilter()
    
    var body: some View {
        FilteredPaginatedView(filter: $filter) { location in
            LocationCard(location: location)
        } filterView: {
            LocationFilterView(filter: $filter)
        }
    }
}

#Preview {
    LocationsView()
        .environmentObject(RickAndMortyAPIService())
}
