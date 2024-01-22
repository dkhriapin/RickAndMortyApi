//
//  PaginatedLastRowView.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 20/01/2024.
//

import SwiftUI

struct PaginatedLastRowView: View {
    @Binding var paginationState: PaginationState
    
    var body: some View {
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
    }
}

#Preview {
    List {
        PaginatedLastRowView(paginationState: .constant(.loading))
        PaginatedLastRowView(paginationState: .constant(.idle))
        PaginatedLastRowView(paginationState: .constant(.error(.apiError("Preview"))))
    }.listStyle(.grouped)
}
