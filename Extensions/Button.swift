//
//  Button.swift
//  KDSwiftUtilities
//
//  Created by KoingDev on 2019/01/29.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import UIKit

protocol Bounceable: AnyObject {
	func enableBouncing()
}

private var buttonBounceableAssociationKey: UInt8 = 0

extension UIButton: Bounceable {
	
	@IBInspectable
	var bounceable: Bool {
		get {
			let bounceable = objc_getAssociatedObject(self, &buttonBounceableAssociationKey) as? Bool
			return bounceable ?? false
		}
		set {
			objc_setAssociatedObject(self, &buttonBounceableAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN)
		}
	}
	
	func enableBouncing() {
		transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
		UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
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

private var buttonLocalizeAssociationKey: UInt8 = 0

extension UIButton {
	
	@IBInspectable
	var localize: String {
		get {
			let localize = objc_getAssociatedObject(self, &buttonLocalizeAssociationKey) as? String
			return localize ?? ""
		}
		set {
			objc_setAssociatedObject(self, &buttonLocalizeAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN)
			setTitle(localize.localized, for: .normal)
		}
	}
	
}