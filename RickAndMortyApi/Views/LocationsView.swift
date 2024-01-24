//
//  LocationsView.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 21/01/2024.
//

import SwiftUI


struct LocationsView: View {
    @EnvironmentObject var apiService: RickAndMortyAPIService
    
    @State private var filter = EmptyFilter()
    
    var body: some View {
        FilteredPaginatedView(filter: $filter) { location in
            LocationCard(location: location)
        } filterView: {
            EmptyView()
        }
    }
}

#Preview {
    LocationsView()
        .environmentObject(RickAndMortyAPIService())
}
