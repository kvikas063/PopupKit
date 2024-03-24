//
//  Extension.swift
//  PopupKit
//
//  Created by Vikas Kumar on 16/03/24.
//

import UIKit

extension UIView {
    func constraintReady() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func cornerRadius(value: CGFloat) {
        layer.cornerRadius = 6
        clipsToBounds = true
    }
}
