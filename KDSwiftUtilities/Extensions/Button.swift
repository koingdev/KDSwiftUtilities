//
//  Button.swift
//  KDSwiftUtilities
//
//  Created by KoingDev on 2019/01/29.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import UIKit

private var buttonLocalizeAssociationKey = 0

extension UIButton {
	
	@IBInspectable
	var localize: String {
		get {
			let localize = objc_getAssociatedObject(self, &buttonLocalizeAssociationKey) as? String
			return localize ?? ""
		}
		set {
			objc_setAssociatedObject(self, &buttonLocalizeAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
			setTitle(localize.localized, for: .normal)
		}
	}
	
}
