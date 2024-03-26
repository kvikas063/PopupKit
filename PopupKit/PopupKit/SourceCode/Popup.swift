//
//  Popup.swift
//  PopupKit
//
//  Created by Vikas Kumar on 12/03/24.
//

import UIKit

/// Popup View class used to show alert type view
/// - This class is used to show alert type of view to highlight some info
public class Popup: UIView {

    // MARK: - UI Properties
    /// Popup container view
    private let containerView = UIView()
    
    /// Popup container stack view
    private let containerStackView = UIStackView()
    
    /// Popup title label
    private let titleLabel = UILabel()
    
    /// Popup sub-title label
    private let subTitleLabel = UILabel()
    
    /// Popup dismiss button
    private let dismissButton = UIButton()
    
    /// Popup Dismiss Completion Handler
    private var dismissTapped: () -> Void

    // MARK: - Popup Height Constraints
    private var heightConstraint: NSLayoutConstraint!
    
    // MARK: - Constants
    private let ScreenBounds = UIScreen.main.bounds
    private let PopupTitle   = "Popup Title"
    private let PopupMessage = "Popup Description Text for long description with title and text"
    private let DismissTitle = "Dismiss"
    
    private let AnimationTime: CGFloat      = 0.5
    private let PopupInitialScale: CGFloat  = 0.1
    private let PopupInitialHeight: CGFloat = 125.0
    
    /// Popup init method
    /// - init method used to set popup `title` and `message` to show Popup view.
    /// - Parameters:
    ///   - title: Popup title text
    ///   - message: Popup message text
    ///   - dismissTitle: Dismiss button title `default` is `OK`
    /// - Returns: An initialized view object.
    public init(
        with title: String,
        message: String,
        dismissTitle: String? = nil,
        dismissTapped: @escaping () -> Void
    ) {
        self.dismissTapped = dismissTapped
        super.init(frame: .zero)
        
        setupViews()

        titleLabel.text = title
        subTitleLabel.text = message
        
        if let buttonTitle = dismissTitle {
            dismissButton.setTitle(buttonTitle, for: .normal)
        }
        
        // Set Height Dynamically based on popup message text
        self.containerView.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.height(for: message)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Set Dismiss button background color
    /// - Parameter color: button background color
    public func setButtonBackground(color: UIColor = .systemBlue) {
        dismissButton.backgroundColor = color
    }
}

// MARK: - Private Helper Methods
private extension Popup {
    
    /// Dismiss Popup View
    /// - dismiss the popup view when dismiss button ( default title is `OK`) is tapped
    @objc func dismissView() {
        animateView(isShowing: false)
    }
    
    /// Get Popup View Height
    /// - Calculate popup height based on popup `message`  text
    /// - Parameter message: Popup message text
    func height(for message: String) {
        var height: CGFloat = PopupInitialHeight
        let nsString = NSString(string: message)
        let rect = nsString.boundingRect(
            with: .init(width: containerStackView.frame.width, height: .greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [.font : subTitleLabel.font as Any],
            context: nil)
        height += rect.height
        heightConstraint.constant = min(max(height, 180), ScreenBounds.height * 0.6)
        
        // Animate Popup View for better UX
        containerView.isHidden = false
        animateView(isShowing: true)
    }
    
    /// Animate popup view while showing and dismissing
    /// - Parameter isShowing: `Bool` flag used to show or dismiss the view
    func animateView(isShowing: Bool) {
        self.containerView.alpha = isShowing ? 0 : 1
        
        let transform:CGAffineTransform = .init(scaleX: PopupInitialScale, y: PopupInitialScale)
        self.containerView.transform = isShowing ? transform : .identity
        
        UIView.animate(withDuration: AnimationTime) {
            self.containerView.alpha = isShowing ? 1 : 0
            self.containerView.transform = isShowing ? .identity : transform
        } completion: { _ in
            if !isShowing {
                self.removeFromSuperview()
                self.dismissTapped()
            }
        }
    }
}

// MARK: - Private Setup Views Methods
private extension Popup {
    
    /// Setup all required views
    func setupViews() {
        setupContainerView()
        setupStackView()
        setupTitleLabel()
        setupSubTitleLabel()
        setupDismissButton()
    }
    
    /// Setup container view
    func setupContainerView() {
        self.frame = ScreenBounds
        self.backgroundColor = .black.withAlphaComponent(0.5)
        containerView.backgroundColor = .secondarySystemBackground
        
        addSubview(containerView)
        containerView.constraintReady()
        containerView.cornerRadius(value: 16)
        
        heightConstraint = containerView.heightAnchor.constraint(equalToConstant: 200)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            heightConstraint
        ])
    }
    
    /// Setup container stack view
    func setupStackView() {
        containerStackView.axis = .vertical
        containerView.addSubview(containerStackView)
        containerStackView.constraintReady()
        
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            containerStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            containerStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            containerStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }
    
    /// Setup Title Label
    func setupTitleLabel() {
        titleLabel.text = PopupTitle
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .label
        
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.setCustomSpacing(12, after: titleLabel)
        
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    /// Setup Sub-Title Label
    func setupSubTitleLabel() {
        subTitleLabel.text = PopupMessage
        subTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        subTitleLabel.textAlignment = .center
        subTitleLabel.numberOfLines = 0
        subTitleLabel.textColor = .secondaryLabel
        subTitleLabel.lineBreakMode = .byWordWrapping
        
        containerStackView.addArrangedSubview(subTitleLabel)
        containerStackView.setCustomSpacing(12, after: subTitleLabel)
    }
    
    /// Setup Dismiss Button View
    func setupDismissButton() {
        dismissButton.backgroundColor = .systemBlue
        dismissButton.setTitle(DismissTitle, for: .normal)
        dismissButton.setTitleColor(.white, for: .normal)
        dismissButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        dismissButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
        containerStackView.addArrangedSubview(dismissButton)
        dismissButton.constraintReady()
        dismissButton.cornerRadius(value: 6)
        dismissButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
}
