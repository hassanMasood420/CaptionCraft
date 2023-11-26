//
//  EditorView.swift
//  Collage
//
//  Created by Hassan on 25/11/2023.
//

import SwiftUI
import PhotosUI

/// The main SwiftUI view for the editor, combining image display, text input, and controls.
struct EditorView: View {
    /// StateObject for managing the editor view model.
    @StateObject var viewModel: EditorViewModel = EditorViewModel()

    var body: some View {
        ZStack(alignment: .topTrailing) {
            // Display the image with text input
           ImageWithTextView(viewModel: viewModel)
                .sheet(isPresented: $viewModel.shouldOpenGallery) {
                    // Present the image picker when needed
                    ImagePickerView(selectedImage: $viewModel.selectedImage)
                }
                .ignoresSafeArea(.keyboard)

            // Display controls for adding text, opening the gallery, and saving the image
            ControlsView(isAddingText: $viewModel.isAddingText, shouldOpenGallery: $viewModel.shouldOpenGallery) {
                // Save the image when the save button is pressed
                viewModel.saveImage(image: ImageWithTextView(viewModel: viewModel).snapshot())
            }
            .padding(16)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EditorView()
    }
}



