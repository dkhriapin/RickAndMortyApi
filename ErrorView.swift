//
//  ErrorView.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 19/01/2024.
//

import SwiftUI

struct ErrorView: View {
    @State var error: Error
    var body: some View {
        VStack {
            Text("⚠️ \(error.localizedDescription)")
        }
    }
}

#Preview {
    ErrorView(error: NSError(domain: "Test Error", code: 0, userInfo: nil))
}
