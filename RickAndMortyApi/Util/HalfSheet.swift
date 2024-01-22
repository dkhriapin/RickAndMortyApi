//
//  HalfSheet.swift
//  RickAndMortyApi
//
//  Created by Dmytro Khriapin on 22/01/2024.
//  Base on "SwiftUI’s Half Sheet for Sleek User Interfaces"
//  https://21zerixpm.medium.com/swiftuis-half-sheet-for-sleek-user-interfaces-c3e77001d96f

import SwiftUI

extension View {
    func halfSheet<SheetView: View>(showSheet: Binding<Bool>, @ViewBuilder sheetView: @escaping () -> SheetView) -> some View {
        return background {
            HalfSheetHelper(sheetView: sheetView(), showSheet: showSheet)
        }
    }
}

struct HalfSheetHelper<SheetView: View>: UIViewControllerRepresentable {
    var sheetView: SheetView
    @Binding var showSheet: Bool
    let controller = UIViewController()
    
    func makeUIViewController(context: Context) -> UIViewController {
        controller.view.backgroundColor = .clear
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if showSheet {
            // presenting Modal View....
            let sheetController = CustomHostingController(rootView: sheetView)
            uiViewController.present(sheetController, animated: true) {
                DispatchQueue.main.async {
                    self.showSheet.toggle()
                }
            }
        }
    }
}

// Custom UIHostingController for halfSheet....
class CustomHostingController<Content: View>: UIHostingController<Content> {
    override func viewDidLoad() {
        // setting presentation controller properties...
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [
                .medium()
            ]
            // To show grab portion...
            presentationController.prefersGrabberVisible = true
        }
    }
}

#Preview {
    CharacterDetailsView(character: .Rick)
        .halfSheet(showSheet: .constant(true), sheetView: {
            // put the UI in here
            CharacterFilterView(filter: .constant(CharacterFilter()))
        })
}
