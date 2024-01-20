//
//  PaginatedView.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 20/01/2024.
//

import SwiftUI


struct PaginatedView<T, CardView: View>: View where T: Identifiable & Pageable, CardView: View {
    private enum PaginationState {
        case idle
        case loading
        case error(Error)
    }
    
    let apiService: RickAndMortyAPIService
    let cardView: (T) -> CardView
    
    @State private var currentPage: Int = 0
    @State private var maxPage: Int?
    @State private var paginationState: PaginationState = .idle
    @State private var pages: [PageResponse<T>] = []
    
    private var isMoreDataAvailable: Bool {
        guard let maxPage = maxPage else { return true }
        return currentPage < maxPage
    }
    
    var lastRowView: some View {
        ZStack(alignment: .center) {
            switch paginationState {
            case .loading:
                ProgressView()
            case .idle:
                EmptyView()
            case .error(let error):
                ErrorView(error: error)
            }
        }
        .frame(height: 50)
        .task {
            paginationState = .loading
            let result: Result<PageResponse<T>, Error> = await apiService.requestPage(currentPage + 1)
            switch result {
            case .success(let page):
                currentPage += 1
                maxPage = page.info.pages
                pages.append(page)
                paginationState = .idle
            case .failure(let error):
                paginationState = .error(error)
            }
        }
    }
    
    var body: some View {
        let items: [T] = self.pages.flatMap { $0.results }
        
        List {
            ForEach(items) { item in
                cardView(item)
                    .listRowSeparator(.hidden)
            }
            if isMoreDataAvailable {
                lastRowView
            }
        }
        .refreshable {
            pages = []
            currentPage = 0
        }
        .listStyle(.grouped)
    }
}

#Preview("CharacterView") {
    PaginatedView(apiService: RickAndMortyAPIService(), cardView: { CharacterCard(character: $0) })
}

#Preview("EpisodeView") {
    PaginatedView(apiService: RickAndMortyAPIService(), cardView: { EpisodeCard(episode: $0) })
}
