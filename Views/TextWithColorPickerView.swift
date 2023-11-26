//
//  TextWithColorPickerView.swift
//  Collage
//
//  Created by Hassan on 25/11/2023.
//

import SwiftUI

/**
 A custom SwiftUI view combining a text input field and a color picker.

 This view allows the user to enter text and choose a text color using a color picker.

 - Parameters:
   - text: A binding to the entered text.
   - hue: The hue value representing the selected text color.
   - position: The position of the text input field.
   - colorPickerPosition: The position of the color picker.
   - isTextFieldFocused: A focus state indicating whether the text field is focused.
   - keyboard: An observed object tracking the keyboard state.

 - Important: Changes to the entered text and selected color are reflected in the parent view.
 */
struct TextWithColorPickerView: View {
    /// A binding to the entered text.
    @Binding var text: String

    /// The hue value representing the selected text color.
    @Binding var hue: Double

    /// The position of the text input field.
    @Binding var position: CGPoint

    /// The position of the color picker.
    @State var colorPickerPosition: CGPoint = CGPoint(x: 0, y: 0)

    /// A focus state indicating whether the text field is focused.
    @FocusState var isTextFieldFocused: Bool

    /// An observed object tracking the keyboard state.
    @ObservedObject var keyboard: KeyboardObserver = KeyboardObserver()
    var body: some View {
        
        VStack {
            Spacer()
            TextField("Enter text", text: $text)
                .multilineTextAlignment(.center)
                .font(.headline)
                .frame(height: 45)
                .background(Color.gray.opacity(0.8))
                .foregroundColor(Color(hue: hue, saturation: 1.0, brightness: 1.0))
                .position(position)
                .focused($isTextFieldFocused)
                .gesture(DragGesture()
                    .onChanged { value in
                        if !(isTextFieldFocused){
                            let a = CGPoint(x: position.x, y: value.location.y)
                            position = a
                        }
                    }
                )
                .onSubmit {
                    isTextFieldFocused = false
                }
                .onAppear{
                    self.keyboard.addObserver()
                }
                .onDisappear {
                    self.keyboard.removeObserver()
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification)) { _ in
                    withAnimation(Animation.linear(duration: 0.1)) {
                        let height = keyboard.height
                        if height < position.y {
                            position = CGPoint(x: position.x, y: height)
                        }
                    }
                }
            
            if isTextFieldFocused {
                ColorSlider(hue: $hue)
                    .padding(.bottom, colorPickerPosition.y)
                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification)) { _ in
                        withAnimation(Animation.linear(duration: 0.1)) {
                            let height = keyboard.height
                            colorPickerPosition = CGPoint(x: position.x, y: height)
                        }
                    }
            }
            Spacer()
        }
    }
}
