//
//  ErrorView.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 19/01/2024.
//

import SwiftUI

struct ErrorView: View {
    @State var error: PageResponseError
    var body: some View {
        VStack {
            Text("⚠️ \(error.localizedDescription)")
        }
    }
}

#Preview {
    ErrorView(error: PageResponseError.invalidURL)
}
