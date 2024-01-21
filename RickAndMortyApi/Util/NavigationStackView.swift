//
//  NavigationStackView.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 21/01/2024.
//

import SwiftUI

struct NavigationStackView<Content>: View where Content: View {
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        if #available(iOS 16, *) {
            NavigationStack(root: content)
        } else {
            NavigationView(content: content)
        }
    }
}
