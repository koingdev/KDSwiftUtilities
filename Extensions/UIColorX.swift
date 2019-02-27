//
//  UIColorX.swift
//  KDSwiftUtilities
//
//  Created by KoingDev on 2/27/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import UIKit

extension UIColor {
	
	convenience init(rgb: UInt) {
		self.init(
			red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
			green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
			blue: CGFloat(rgb & 0x0000FF) / 255.0,
			alpha: CGFloat(1.0)
		)
	}
	
}
