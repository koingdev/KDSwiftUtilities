//
//  UIButtonX.swift
//  KDSwiftUtilities
//
//  Created by KoingDev on 2019/01/29.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import UIKit

// MARK: Associated Key

extension UIButton {
	
	fileprivate struct AssociatedKeys {
		static var BounceableKey: UInt8 = 0
		static var LocalizationKey: UInt8 = 0
	}
	
}

extension UIButton {
	
	@IBInspectable
	var localize: String {
		get {
			let localize = objc_getAssociatedObject(self, &AssociatedKeys.LocalizationKey) as? String
			return localize ?? ""
		}
		set {
			objc_setAssociatedObject(self, &AssociatedKeys.LocalizationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
			setTitle(localize.localized, for: .normal)
		}
	}
	
	// MARK: - Bouce
	
	@IBInspectable
	var bounceable: Bool {
		get {
			let bounceable = objc_getAssociatedObject(self, &AssociatedKeys.BounceableKey) as? Bool
			return bounceable ?? false
		}
		set {
			objc_setAssociatedObject(self, &AssociatedKeys.BounceableKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}
	
	func enableBouncing() {
		transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
		UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
			// reset to default
			self.transform = CGAffineTransform.identity
		})
	}
	
	override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		if bounceable {
			enableBouncing()
		}
		super.touchesBegan(touches, with: event)
	}
	
}
