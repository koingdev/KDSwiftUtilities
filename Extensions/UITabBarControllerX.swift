//
//  UITabBarControllerX.swift
//  KDSwiftUtilities
//
//  Created by KoingDev on 2/27/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import UIKit

extension UITabBarController {
	
	func setMiddleButton(_ button: UIButton) {
		let heightDifference: CGFloat = button.height - tabBar.frame.size.height
		if heightDifference < 0 {
			button.center = tabBar.center
		} else {
			var center: CGPoint = tabBar.center
			center.y = center.y - heightDifference / 2.0
			button.center = center
		}
		
		view.addSubview(button)
	}
	
}
