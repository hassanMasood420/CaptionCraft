//
//  ImagePickerView.swift
//  Collage
//
//  Created by Hassan on 25/11/2023.
//

import SwiftUI
import UIKit

import SwiftUI

/// A SwiftUI view for picking an image from the photo library.
struct ImagePickerView: UIViewControllerRepresentable {
    /// Binding to the selected image.
    @Binding var selectedImage: UIImage?

    /// Coordinator class to handle UIImagePickerControllerDelegate methods.
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePickerView

        /// Initializes the Coordinator with a reference to the parent view.
        init(parent: ImagePickerView) {
            self.parent = parent
        }

        /// Called when an image is picked from the photo library.
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                parent.selectedImage = selectedImage
            }

            // Dismiss the UIImagePickerController
            parent.presentationMode.wrappedValue.dismiss()
        }

        /// Called when the user cancels image picking.
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            // Dismiss the UIImagePickerController
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    /// Environment variable to access the presentation mode.
    @Environment(\.presentationMode) var presentationMode

    /// Creates a Coordinator instance.
    /// - Returns: A Coordinator instance.
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    /// Creates a UIImagePickerController.
    /// - Parameter context: The context for the UIViewControllerRepresentable.
    /// - Returns: A configured UIImagePickerController.
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    /// Updates the UIImagePickerController (not used in this implementation).
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    /// Opens the photo library when the button is tapped.
    func didTapButton() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary

            // Present the UIImagePickerController from the root view controller
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                let windows = windowScene.windows
                windows.first?.rootViewController?.present(picker, animated: true, completion: nil)
            }
        }
    }
}

