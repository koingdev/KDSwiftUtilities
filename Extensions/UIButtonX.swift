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
	
	override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		if bounceable {
			bounce()
		}
		super.touchesBegan(touches, with: event)
	}
	
	func alignImageAndTitleVertically(padding: CGFloat = 3.0) {
		guard let imageView = imageView, let titleLabel = titleLabel else { return }
		let imageSize = imageView.frame.size
		let titleSize = titleLabel.bounds.size
		imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + padding), left: 0, bottom: 0, right: -titleSize.width)
		titleEdgeInsets = UIEdgeInsets(top: imageSize.height + padding, left: -imageSize.width, bottom: 0, right: 0)
	}
	
}
