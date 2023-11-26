//
//  KeyboardObserver.swift
//  Collage
//
//  Created by Hassan on 25/11/2023.
//

import SwiftUI

import UIKit

/// An observable class for monitoring the keyboard's visibility and height changes.
class KeyboardObserver: ObservableObject {
    /// Published property indicating whether the keyboard is currently visible.
    @Published var isShowing = false
    
    /// Published property representing the height of the keyboard.
    @Published var height: CGFloat = 320
    
    /// Adds observers for keyboard show and hide notifications.
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /// Removes previously added keyboard show and hide observers.
    func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /// Called when the keyboard is about to be shown.
    /// - Parameter notification: The keyboard show notification.
    @objc func keyboardWillShow(_ notification: Notification) {
        isShowing = true
        guard let userInfo = notification.userInfo as? [String: Any] else {
            return
        }
        guard let keyboardInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardSize = keyboardInfo.cgRectValue.size
        height = keyboardSize.height
    }
    
    /// Called when the keyboard is about to be hidden.
    /// - Parameter notification: The keyboard hide notification.
    @objc func keyboardWillHide(_ notification: Notification) {
        isShowing = false
        height = 0
    }
}

