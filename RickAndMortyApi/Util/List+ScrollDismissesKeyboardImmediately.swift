//
//  List+ScrollDismissesKeyboardImmediately.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 22/01/2024.
//

import SwiftUI

extension List {
    func scrollDismissesKeyboardImmediately() -> some View {
        if #available(iOS 16.0, *) {
            return self.scrollDismissesKeyboard(.immediately)
        }
        return self
    }
}
