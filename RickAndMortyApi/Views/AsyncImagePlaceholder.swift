//
//  AsyncImagePlaceholder.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 21/01/2024.
//

import SwiftUI

struct AsyncImagePlaceholder: View {
    private let coverPlaceholderBackgroundColor = Color(red: 0.8, green: 0.8, blue: 0.8)
    private let coverPlaceholderForegroundColor = Color.gray
    
    var body: some View {
        ZStack{
            Image(systemName: "photo")
                .resizable()
                .padding(10)
                .aspectRatio(1, contentMode: .fit)
                .background(coverPlaceholderBackgroundColor)
                .foregroundColor(coverPlaceholderForegroundColor)
        }
    }
}

#Preview {
    AsyncImagePlaceholder()
        .padding()
}
