//
//  DesignableButton.swift
//  KDWeddingGift
//
//  Created by KoingDev on 2/8/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableButton: UIButton {
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	// MARK: - Bouce
	
	@IBInspectable
	var animateOnTouch: Bool = false
	
	private func animateOnTouchBegin() {
		if animateOnTouch {
			UIView.animate(withDuration: 0.3, delay: 0, options: [.allowUserInteraction, .curveEaseOut], animations: {
				self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
				self.alpha = 0.7
			})
		}
	}
	
	private func animateOnTouchEnd() {
		if animateOnTouch {
			UIView.animate(withDuration: 0.3, delay: 0, options: [.allowUserInteraction, .curveEaseIn], animations: {
				self.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
				self.alpha = 1.0
			})
		}
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesBegan(touches, with: event)
		animateOnTouchBegin()
	}
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touch = touches.first else { return }
		if bounds.contains(touch.location(in: self)) {
			animateOnTouchBegin()
		} else {
			animateOnTouchEnd()
		}
	}
	
	override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesCancelled(touches, with: event)
		animateOnTouchEnd()
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesEnded(touches, with: event)
		animateOnTouchEnd()
	}
	
	// MARK: - Gradient
	
	@IBInspectable var firstColor: UIColor = UIColor.white {
		didSet {
			updateView()
		}
	}
	
	@IBInspectable var secondColor: UIColor = UIColor.white {
		didSet {
			updateView()
		}
	}
	
	@IBInspectable var horizontalGradient: Bool = false {
		didSet {
			updateView()
		}
	}
	
	override public class var layerClass: AnyClass {
		get {
			return CAGradientLayer.self
		}
	}
	
	fileprivate func updateView() {
		let layer = self.layer as! CAGradientLayer
		layer.colors = [ firstColor.cgColor, secondColor.cgColor ]
		
		if (horizontalGradient) {
			layer.startPoint = CGPoint(x: 0.0, y: 0.5)
			layer.endPoint = CGPoint(x: 1.0, y: 0.5)
		} else {
			layer.startPoint = CGPoint(x: 0, y: 0)
			layer.endPoint = CGPoint(x: 0, y: 1)
		}
	}
	
}
