//
//  UILabelX.swift
//  KDSwiftUtilities
//
//  Created by KoingDev on 2019/01/29.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import UIKit

// MARK: Associated Key

extension UILabel {
	
	fileprivate struct AssociatedKeys {
		static var LocalizationKey: UInt8 = 0
	}
	
}

extension UILabel {
	
	@IBInspectable
	var localize: String {
		get {
			let localize = objc_getAssociatedObject(self, &AssociatedKeys.LocalizationKey) as? String
			return localize ?? ""
		}
		set {
			objc_setAssociatedObject(self, &AssociatedKeys.LocalizationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
			text = localize.localized
		}
	}
	
}
