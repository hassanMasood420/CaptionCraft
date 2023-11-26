//
//  EditorViewModel.swift
//  Collage
//
//  Created by Hassan on 25/11/2023.
//


import SwiftUI
import Combine

/**
 A view model class responsible for managing the state and actions related to the editor functionality.

 - Note: This class conforms to the ObservableObject protocol to enable data binding with SwiftUI views.

 - Important: The class includes properties for text, position, whether text is being added, whether the gallery should be opened, and the selected image.

 */
class EditorViewModel: ObservableObject {

    /// The text to be displayed or edited in the editor.
    @Published var text: String = ""
    
    /// The color hue for text used to be displayed or edited in the editor.
    @Published var hue: Double = 1

    /// The position of the editor in the coordinate system.
    @Published var position: CGPoint = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)

    /// A boolean indicating whether text is currently being added.
    @Published var isAddingText: Bool = false

    /// A boolean indicating whether the gallery should be opened.
    @Published var shouldOpenGallery: Bool = false

    /// The selected image for the editor.
    @Published var selectedImage: UIImage? = UIImage(named: "girl1")

    /**
     Saves the given image to the photo album.

     - Parameter image: The image to be saved.
     */
    func saveImage(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}

