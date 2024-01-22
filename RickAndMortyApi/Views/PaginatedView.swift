//
//  PaginatedView.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 20/01/2024.
//

import SwiftUI


enum PaginationState: Equatable {
    case idle
    case loading
    case error(PageResponseError)
    
    static func == (lhs: PaginationState, rhs: PaginationState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle): return true
        case (.loading, .loading): return true
        case (.error(let lhsError), .error(let rhsError)): return lhsError == rhsError
        default: return false
        }
    }
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
        currentPage = 0
        maxPage = nil
        paginationState = .idle
        pages = []
    }
    
    private func loadPage() async {
        paginationState = .loading
        let result: Result<PageResponse<T>, Error> = await apiService.requestPage(currentPage + 1, with: filter)
        switch result {
        case .success(let page):
            currentPage += 1
            maxPage = page.info?.pages
            pages.append(page)
            paginationState = .idle
        case .failure(let error as PageResponseError):
            paginationState = .error(error)
        case .failure(let generic):
            paginationState = .error(.genericError(generic.localizedDescription))
        }
    }
    
    private var isMoreDataAvailable: Bool {
        guard let maxPage = maxPage else { return true }
        return currentPage < maxPage
    }
    
    var body: some View {
        let items: [T] = self.pages.flatMap { $0.results ?? [] }
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
                            if paginationState == .idle {
                                await loadPage()
                            }
                        }
                }
            }
            .scrollDismissesKeyboardImmediately()
            .refreshable {
                reset()
                await loadPage()
            }
            .listStyle(.plain)
            .onChange(of: filter) { value in
                Task {
                    if let first = items.first {
                        proxy.scrollTo(first)
                    }
                    reset()
                    await loadPage()
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
