//
//  UIViewX.swift
//  KDSwiftUtilities
//
//  Created by KoingDev on 2/2/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import UIKit

// MARK: Associated Key

extension UIView {
	
	fileprivate struct AssociatedKeys {
		static var GradientFirstColorKey: UInt8 = 0
		static var GradientSecondColorKey: UInt8 = 0
		static var GradientHorizontalKey: UInt8 = 0
	}
	
}

extension UIView {
	
	// MARK: - Gradient
	
	func applyGradient(firstColor: UIColor, secondColor: UIColor, isHorizontal: Bool = false) {
		let gradient = CAGradientLayer()
		gradient.frame = bounds
		gradient.colors = [firstColor.cgColor, secondColor.cgColor]
		if isHorizontal {
			gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
			gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
		} else {
			gradient.startPoint = CGPoint(x: 0, y: 0)
			gradient.endPoint = CGPoint(x: 0, y: 1)
		}
		layer.addSublayer(gradient)
	}
	
//	@IBInspectable var firstColor: UIColor {
//		get {
//			let firstColor = objc_getAssociatedObject(self, &AssociatedKeys.GradientFirstColorKey) as? UIColor
//			return firstColor ?? UIColor.clear
//		}
//		set {
//			objc_setAssociatedObject(self, &AssociatedKeys.GradientFirstColorKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//			applyGradient()
//		}
//	}
//
//	@IBInspectable var secondColor: UIColor {
//		get {
//			let secondColor = objc_getAssociatedObject(self, &AssociatedKeys.GradientSecondColorKey) as? UIColor
//			return secondColor ?? UIColor.clear
//		}
//		set {
//			objc_setAssociatedObject(self, &AssociatedKeys.GradientSecondColorKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//			applyGradient()
//		}
//	}
//
//	@IBInspectable var horizontalGradient: Bool {
//		get {
//			let horizontalGradient = objc_getAssociatedObject(self, &AssociatedKeys.GradientHorizontalKey) as? Bool
//			return horizontalGradient ?? false
//		}
//		set {
//			objc_setAssociatedObject(self, &AssociatedKeys.GradientHorizontalKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//			applyGradient()
//		}
//	}
	
	// MARK: - Border
	
	@IBInspectable var cornerRadius: CGFloat {
		get {
			return layer.cornerRadius
		}
		set {
			layer.cornerRadius = newValue
			layer.masksToBounds = newValue > 0
		}
	}
	
	@IBInspectable var borderWidth: CGFloat {
		get {
			return layer.borderWidth
		}
		set {
			layer.borderWidth = newValue
		}
	}
	
	@IBInspectable var borderColor: UIColor? {
		get {
			return UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor)
		}
		set {
			layer.borderColor = newValue?.cgColor
		}
	}
	
	// MARK: - Shadow
	
	@IBInspectable var shadowOpacity: Float {
		get {
			return layer.shadowOpacity
		}
		set {
			layer.shadowOpacity = newValue
		}
	}
	
	@IBInspectable var shadowColor: UIColor {
		get {
			return UIColor(cgColor: layer.shadowColor ?? UIColor.clear.cgColor)
		}
		set {
			layer.shadowColor = newValue.cgColor
		}
	}
	
	@IBInspectable var shadowRadius: CGFloat {
		get {
			return layer.shadowRadius
		}
		set {
			layer.shadowRadius = newValue
		}
	}
	
	@IBInspectable var shadowOffsetY: CGFloat {
		get {
			return layer.shadowOffset.height
		}
		set {
			layer.shadowOffset.height = newValue
		}
	}
	
}

// MARK: Animation

extension UIView {
	
	enum ShakeDirection {
		case horizontal
		case vertical
	}
	
	func bounce(duration: TimeInterval = 0.8, completion: (() -> Void)? = nil) {
		transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
		UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
			// reset to default
			self.transform = CGAffineTransform.identity
		}, completion: { _ in
			completion?()
		})
	}
	
	func shake(direction: ShakeDirection = .horizontal, duration: TimeInterval = 0.8, completion: (() -> Void)? = nil) {
		CATransaction.begin()
		let animation: CAKeyframeAnimation
		switch direction {
		case .horizontal:
			animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
		case .vertical:
			animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
		}
		animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
		CATransaction.setCompletionBlock(completion)
		animation.duration = duration
		animation.values = [-15.0, 15.0, -15.0, 15.0, -10.0, 10.0, -5.0, 5.0, 0.0]
		layer.add(animation, forKey: "shake")
		CATransaction.commit()
	}
	
	func popIn(duration: TimeInterval = 0.8, completion: (() -> Void)? = nil) {
		transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
		UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
			self.transform = CGAffineTransform.identity
		}, completion: { _ in
			completion?()
		})
	}
	
	func rotate(byAngle angle: CGFloat, animated: Bool = false, duration: TimeInterval = 0.8, completion: (() -> Void)? = nil) {
		let angle = .pi * angle / 180.0
		let duration = animated ? duration : 0
		UIView.animate(withDuration: duration, delay: 0, options: [.curveLinear, .allowUserInteraction], animations: { () -> Void in
			self.transform = self.transform.rotated(by: angle)
		}, completion: { _ in
			completion?()
		})
	}
	
	func scale(by offset: CGPoint, animated: Bool = false, duration: TimeInterval = 0.8, completion: (() -> Void)? = nil) {
		if animated {
			UIView.animate(withDuration: duration, delay: 0, options: [.curveLinear, .allowUserInteraction], animations: { () -> Void in
				self.transform = self.transform.scaledBy(x: offset.x, y: offset.y)
			}, completion: { _ in
				completion?()
			})
		} else {
			transform = transform.scaledBy(x: offset.x, y: offset.y)
			completion?()
		}
	}
	
	func fadeIn(duration: TimeInterval = 0.8, completion: (() -> Void)? = nil) {
		alpha = 0
		UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseOut, .allowUserInteraction], animations: {
			self.alpha = 1
		}, completion: { _ in
			completion?()
		})
	}
	
	func fadeOut(duration: TimeInterval = 0.8, completion: (() -> Void)? = nil) {
		alpha = 1
		UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseOut, .allowUserInteraction], animations: {
			self.alpha = 0
		}, completion: { _ in
			completion?()
		})
	}
	
}

// MARK: Auto Layout Extension

extension UIView {
	
	func fillSuperview() {
		guard let superview = superview else {
			Log.warning("No superview cannot fill superview constraint")
			return
		}
		anchor(top: superview.topAnchor, bottom: superview.bottomAnchor, leading: superview.leadingAnchor, trailing: superview.trailingAnchor)
		superview.layoutIfNeeded()
	}
	
	func anchor(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, margin: UIEdgeInsets = .zero, size: CGSize = .zero) {
		translatesAutoresizingMaskIntoConstraints = false
		if let top = top {
			topAnchor.constraint(equalTo: top, constant: margin.top).isActive = true
		}
		if let bottom = bottom {
			bottomAnchor.constraint(equalTo: bottom, constant: -margin.bottom).isActive = true
		}
		if let leading = leading {
			leadingAnchor.constraint(equalTo: leading, constant: margin.left).isActive = true
		}
		if let trailing = trailing {
			trailingAnchor.constraint(equalTo: trailing, constant: -margin.right).isActive = true
		}
		if size.width != 0 {
			widthAnchor.constraint(equalToConstant: size.width).isActive = true
		}
		if size.height != 0 {
			heightAnchor.constraint(equalToConstant: size.height).isActive = true
		}
	}
	
}
