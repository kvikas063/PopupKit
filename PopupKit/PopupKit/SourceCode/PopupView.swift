//
//  PopupView.swift
//  PopupKit
//
//  Created by Vikas Kumar on 28/03/24.
//

import SwiftUI

public final class PopupKit {
    public let name: String
    public let age: Int
    
    public init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

/// A SwiftUI view representable for ``Popup`` class
public struct PopupView: UIViewRepresentable {
    public typealias UIViewType = Popup
    
    /// Popup Title
    public let title: String
    
    /// Popup Message
    public let message: String
    
    /// Popup Dismiss Button Title
    public var dismissTitle: String? = nil
    
    /// Popup Dismiss Button Action Handler
    public let dismissTapped: () -> Void
    
    /// Creates an instance of Popup View
    /// - Parameter context: context description
    /// - Returns: Popup View instance
    public func makeUIView(context: Context) -> Popup {
        // Return MyView instance.
        let popup = Popup(with: title, message: message, dismissTitle: dismissTitle, dismissTapped: dismissTapped)
        return popup
    }
    
    /// Updates the state of the specified view with new information from SwiftUI
    /// - Parameters:
    ///   - uiView: Popup View
    ///   - context: context description
    public func updateUIView(_ uiView: Popup, context: Context) {
        // Updates the state of the specified view with new information from SwiftUI.
    }
}
