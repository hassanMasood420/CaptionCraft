//
//  EditorControlView.swift
//  Collage
//
//  Created by Hassan on 25/11/2023.
//

import SwiftUI

/// A SwiftUI view that provides control buttons for adding text, saving the image, and opening the gallery.
struct ControlsView: View {
    /// Binding to control the visibility of text input.
    @Binding var isAddingText: Bool
    
    /// Binding to trigger the gallery opening.
    @Binding var shouldOpenGallery: Bool
    
    /// Closure to save the image.
    var saveImage: () -> Void

    var body: some View {
        HStack {
            // Button to toggle text input visibility
            Button("T") {
                isAddingText.toggle()
            }
            .padding()

            // Button to trigger image saving
            Button("Save") {
                saveImage()
            }
            .padding()

            // Button to toggle gallery visibility
            Button("Gallery") {
                shouldOpenGallery.toggle()
            }
            .padding()
        }
        // Styling for the control buttons
        .background(Color.black.opacity(0.8))
        .cornerRadius(10)
        .foregroundColor(.white)
    }
}



