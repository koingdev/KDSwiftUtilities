//
//  KeyboardService.swift
//  KDSwiftUtilities
//
//  Created by KoingDev on 2/2/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import UIKit

// MARK: Keyboard Layout Constraint

final class KeyboardLayoutConstraint: NSLayoutConstraint {
    
    @IBInspectable var inverted: Bool = false
    @IBInspectable var distanceFromKeyboard: CGFloat = 0
	private var defaultConstant: CGFloat = 0
	private var multiply: CGFloat {
		return inverted ? -1.0 : 1.0
	}
    
    private var keyboardObserver: KeyboardObserver!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Already initialized?
        if keyboardObserver != nil {
            return
        }
		
		defaultConstant = self.constant
		
        keyboardObserver = KeyboardObserver { [weak self] height in
            guard let self = self else { return }
            let newConstant = (self.defaultConstant + height * self.multiply) + self.distanceFromKeyboard
			
            if newConstant != self.constant {
                self.constant = newConstant
                UIViewController.topMostViewController.view.layoutIfNeeded()
            }
        }
    }
}

// MARK: Keyboard Observer

final class KeyboardObserver: NSObject {
    
    fileprivate var keyboardWillChange: (CGFloat) -> Void
    fileprivate(set) var isVisible: Bool = false
    fileprivate(set) var keyboardFrame: CGRect = CGRect.zero
    
    fileprivate lazy var tapOutsideGesture: UITapGestureRecognizer = {
        let tapOutsideGesture = UITapGestureRecognizer(target: self, action: #selector(tapOutsideRecognized))
        tapOutsideGesture.cancelsTouchesInView = false
        tapOutsideGesture.delegate = self
        return tapOutsideGesture
    }()
    
    init(keyboardWillChange: @escaping (CGFloat) -> Void) {
        self.keyboardWillChange = keyboardWillChange
        super.init()
        
        // Will Show
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: OperationQueue.main) { [weak self] notification in
            guard let self = self else { return }
            guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                return
            }
            self.keyboardFrame = keyboardFrame
            self.isVisible = true
            UIApplication.shared.keyWindow?.addGestureRecognizer(self.tapOutsideGesture)
            
            // Animate
            UIView.animate(withDuration: 0, delay: 0, options: [.curveEaseOut, .allowUserInteraction], animations: {
                self.keyboardWillChange(self.keyboardFrame.height)
            })
        }
        
        // Will Hide
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: OperationQueue.main) {
            [weak self] notification in
            guard let self = self else { return }
            self.keyboardFrame = .zero
            self.isVisible = false
            self.tapOutsideGesture.view?.removeGestureRecognizer(self.tapOutsideGesture)
            
            // Animate
            UIView.animate(withDuration: 0, delay: 0, options: [.curveEaseOut, .allowUserInteraction], animations: {
                self.keyboardWillChange(self.keyboardFrame.height)
            })
        }
    }
    
    // Tap outside to dismiss keyboard
    @objc func tapOutsideRecognized(_ gesture: UITapGestureRecognizer) {
        if gesture.state == .ended {
            UIApplication.shared.keyWindow?.endEditing(true)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: Gesture Delegate

extension KeyboardObserver: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        // Ignore touch on controlls
        for ignoreClass in [UIControl.self, UINavigationBar.self] {
            if touch.view?.isKind(of: ignoreClass) == true {
                return false
            }
        }
        return true
    }
    
}
