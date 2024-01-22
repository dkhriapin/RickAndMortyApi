//
//  PaginatedView.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 20/01/2024.
//

import SwiftUI


enum PaginationState {
    case idle
    case loading
    case error(Error)
}

struct PaginatedView<T, CardView: View, U>: View where T: Identifiable & Hashable & Pageable, CardView: View, U: APIFilter {
    
    let apiService: RickAndMortyAPIService
    @Binding var filter: U
    let cardView: (T) -> CardView
    
    @State private var currentPage: Int = 0
    @State private var maxPage: Int?
    @State private var paginationState: PaginationState = .idle
    @State private var pages: [PageResponse<T>] = []
    
    private func reset() {
        print("reset")
        currentPage = 0
        maxPage = nil
        paginationState = .idle
        pages = []
    }
    
    private func loadPage() async {
        print("fetch page: \(currentPage + 1)")
        paginationState = .loading
        let result: Result<PageResponse<T>, Error> = await apiService.requestPage(currentPage + 1, with: filter)
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
    
    private var isMoreDataAvailable: Bool {
        guard let maxPage = maxPage else { return true }
        return currentPage < maxPage
    }
    
    var body: some View {
        let items: [T] = self.pages.flatMap { $0.results }
        ScrollViewReader { proxy in
            List {
                ForEach(items) { item in
                    cardView(item)
                        .listRowSeparator(.hidden)
                        .id(item)
                }
                if isMoreDataAvailable {
                    PaginatedLastRowView(paginationState: $paginationState)
                        .task {
                            await loadPage()
                        }
                }
            }
            .scrollDismissesKeyboardImmediately()
            .refreshable {
                reset()
            }
            .listStyle(.plain)
            .onChange(of: filter) { value in
                Task {
                    proxy.scrollTo(items.first!)
                    reset()
                }
            }
        }
    }
}

#Preview("CharacterView") {
    PaginatedView(apiService: RickAndMortyAPIService(), filter: .constant(CharacterFilter()), cardView: { char in
        CharacterCard(character: char)
            .background(NavigationLink("", destination: { Text(char.name) }).opacity(0))
    })
}

#Preview("EpisodeView") {
    PaginatedView(apiService: RickAndMortyAPIService(), filter: .constant(CharacterFilter()), cardView: { EpisodeCard(episode: $0) })
}
