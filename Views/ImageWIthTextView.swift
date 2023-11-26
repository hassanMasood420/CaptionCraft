//
//  ImageWIthTextView.swift
//  Collage
//
//  Created by Hassan on 26/11/2023.
//

import SwiftUI

/// A SwiftUI view that combines an image display with the option to add text using `TextWithColorPickerView`.
struct ImageWithTextView: View {
    /// The view model managing the editor state.
    @ObservedObject var viewModel: EditorViewModel

    var body: some View {
        ZStack {
            // Display the selected image if available
            if let image = viewModel.selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width)
            }

            // Display the text input view if adding text is enabled
            if viewModel.isAddingText {
                TextWithColorPickerView(text: $viewModel.text, hue: $viewModel.hue, position: $viewModel.position)
            }
        }
    }
}

//struct ImageWithTextView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageWithTextView()
//    }
//}
