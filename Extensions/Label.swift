//
//  Label.swift
//  KDSwiftUtilities
//
//  Created by KoingDev on 2019/01/29.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import UIKit

private var labelLocalizeAssociationKey: UInt8 = 0

extension UILabel {
	
	@IBInspectable
	var localize: String {
		get {
			let localize = objc_getAssociatedObject(self, &labelLocalizeAssociationKey) as? String
			return localize ?? ""
		}
		set {
			objc_setAssociatedObject(self, &labelLocalizeAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
			text = localize.localized
		}
	}
	
}
