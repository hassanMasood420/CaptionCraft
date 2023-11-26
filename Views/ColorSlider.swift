//
//  ColorSlider.swift
//  Collage
//
//  Created by Hassan on 25/11/2023.
//

import SwiftUI

/**
 A custom SwiftUI view representing a color slider.

 The color slider allows the user to select a color by dragging a circle along a gradient background.

 - Parameters:
   - hue: A binding to the hue value of the selected color.
   - position: The position of the circle indicating the selected hue.

 - Important: The hue value is bound to this view, and changes are reflected in the parent view.

 */
struct ColorSlider: View {
    /// A binding to the hue value of the selected color.
    @Binding var hue: Double

    /// The position of the circle indicating the selected hue.
    @State var position: CGPoint = CGPoint(x: 50, y: 0)
    
    var body: some View {
        VStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 1, green: 0, blue: 0),
                                            Color(red: 1, green: 1, blue: 0),
                                            Color(red: 0, green: 1, blue: 0),
                                            Color(red: 0, green: 1, blue: 1),
                                            Color(red: 0, green: 0, blue: 1),
                                            Color(red: 1, green: 0, blue: 1),
                                            Color(red: 1, green: 0, blue: 0)]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .mask(
                RoundedRectangle(cornerRadius: 15)
                    .frame(height: 30)
            )
            .overlay(
                Circle()
                    .fill(Color.white)
                    .frame(width: 30, height: 40)
                    .shadow(color: Color.gray, radius: 2)
                    .position(position)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let x = value.location.x
                                let width = UIScreen.main.bounds.width - 30
                                let percent = min(max(x / width, 0.0), 1.0)
                                hue = Double(percent)
                                position = CGPoint(x: x, y: 0)
                            }
                    )
            )
        }
        .padding(15)
        .frame(height: 31)
    }
}
