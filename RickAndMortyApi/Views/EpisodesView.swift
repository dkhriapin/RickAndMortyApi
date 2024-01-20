//
//  EpisodesView.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 19/01/2024.
//

import SwiftUI


struct EpisodesView: View {
    private enum PaginationState {
        case idle
        case loading
        case error(Error)
    }
    
    let apiService = RickAndMortyAPIService()
    @State private var currentPage: Int = 0
    @State private var maxPage: Int?
    @State private var paginationState: PaginationState = .idle
    @State private var pages: [PageResponse<Episode>] = []
    
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
            let result = await apiService.requestEpisodesPage(currentPage + 1)
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
        var episodes: [Episode] {
            self.pages.flatMap{ $0.results }
        }
        List() {
            ForEach(episodes, id: \.id) { episode in
                EpisodeCard(episode: episode)
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


#Preview {
    EpisodesView()
}
