//
//  Extension View.swift
//  Collage
//
//  Created by Hassan on 25/11/2023.
//

import SwiftUI

/**
 A SwiftUI View extension to capture a snapshot of the view hierarchy as a UIImage.

 This extension provides a convenient method for capturing a snapshot of the current SwiftUI view hierarchy.

 - Returns: A UIImage representing the rendered content of the view.

 - Important: The captured image may not include animations or dynamic content.

 */
extension View {
    /**
     Captures a snapshot of the view hierarchy as a UIImage.

     - Returns: A UIImage representing the rendered content of the view.

     - Important: The captured image may not include animations or dynamic content.
     */
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}

