//
//  HighlightView.swift
//  KDWeddingGift
//
//  Created by KoingDev on 2/8/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import UIKit

class HighlightView: UIView {
	
	var delay: Double = 0
	var enabled: Bool = false
	var isWaiting: Bool = false	// Waiting to remove the Highlight
	var action: (() -> Void)? = nil
	let highlightColor = UIColor.black.withAlphaComponent(0.2)
	
	var isHighlighted: Bool {
		return backgroundColor == highlightColor
	}
	
	@discardableResult
	static func addHighlightToView(_ view: UIView) -> HighlightView {
		let newHighlightView = HighlightView()
		view.addSubview(newHighlightView)
		newHighlightView.frame = view.bounds
		newHighlightView.fillSuperview()
		newHighlightView.enabled = true
		newHighlightView.cornerRadius = view.cornerRadius
		newHighlightView.isExclusiveTouch = true
		newHighlightView.isMultipleTouchEnabled = false
		newHighlightView.isUserInteractionEnabled = true
		return newHighlightView
	}
	
	func showHighlight() {
		backgroundColor = highlightColor
	}
	
	func hideHighlight() {
		backgroundColor = UIColor.clear
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		if enabled {
			showHighlight()
			
			// Hack for disappearing Touch
			if let touch = touches.first {
				Queue.runAfter(delay + 0.5) { [weak touch] in
					if touch == nil && !self.isWaiting && self.isHighlighted {
						print("HighlightView HACK to fix 'Gesture: Failed to receive system gesture state notification before next touch'")
						self.hideHighlight()
					}
				}
			}
		}
	}
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touch = touches.first else { return }
		if bounds.contains(touch.location(in: self)) {
			showHighlight()
		} else {
			hideHighlight()
		}
	}
	
	override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
		hideHighlight()
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		
		// Touch is outside button?
		guard let touch = touches.first else { return }
		if !bounds.contains(touch.location(in: self)) {
			self.hideHighlight()
			return
		}
		
		// Avoid multiple touches when main thread is blocked
		if !isUserInteractionEnabled {
			return
		}
		isUserInteractionEnabled = false
		
		// Remove highlight after the delay
		isWaiting = true
		Queue.runAfter(delay) {
			self.isUserInteractionEnabled = true
			self.hideHighlight()
			self.isWaiting = false
		}
		
		// Action
		UIApplication.shared.keyWindow?.endEditing(true)
		action?()
	}
	
}

extension UIView {
	
	private var highlightView: HighlightView {
		for case let subview as HighlightView in subviews {
			return subview
		}
		return HighlightView.addHighlightToView(self)
	}
	
	@IBInspectable var hlEnabled: Bool {
		get {
			return highlightView.enabled
		}
		set {
			highlightView.enabled = newValue
			isUserInteractionEnabled = newValue
		}
	}
	
	func setAction(delayHighlight: Double = 0, action: (() -> Void)?) {
		let hl = highlightView
		hl.delay = delayHighlight
		hl.action = action
	}
	
}
