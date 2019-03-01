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
		view.addSubview(button)
		AutoLayoutBuilder(button)
			.bottomTo(view.layoutMarginsGuide.bottomAnchor)
			.centerXTo(view.centerXAnchor)
			.width(value: button.width)
			.height(value: button.height)
			.build()
	}
	
}
