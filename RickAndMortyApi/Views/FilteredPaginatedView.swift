//
//  FilteredPaginatedView.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 24/01/2024.
//

import SwiftUI

struct FilteredPaginatedView<Item, CardView: View, Filter, FilterView: View>: View where Item: Identifiable & Hashable & Pageable, CardView: View, Filter: APIFilter {
    @EnvironmentObject var apiService: RickAndMortyAPIService
    
    @Binding var filter: Filter
    let cardView: (Item) -> CardView
    let filterView: () -> FilterView
    
    @State private var showingFilterSheet = false
    
    var body: some View {
        NavigationStackView {
            if filter is EmptyFilter {
                PaginatedView(filter: $filter, cardView: cardView)
                    .navigationBarTitleDisplayMode(.inline)
            } else {
                PaginatedView(filter: $filter, cardView: cardView)
                    .toolbar {
                        Button {
                            showingFilterSheet.toggle()
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease")
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .halfSheet(showSheet: $showingFilterSheet, sheetView: { filterView() })
            }
        }
    }
}

#Preview {
    CharactersView().environmentObject(RickAndMortyAPIService())
}

#Preview {
    EpisodesView().environmentObject(RickAndMortyAPIService())
}

