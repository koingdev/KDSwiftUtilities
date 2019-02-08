//
//  DesignableButton.swift
//  KDWeddingGift
//
//  Created by KoingDev on 2/8/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import UIKit

@IBDesignable
final class DesignableButton: UIButton {
	
	// MARK: - Gradient
	
	@IBInspectable var firstColor: UIColor = UIColor.white {
		didSet {
			updateView()
		}
	}
	
	@IBInspectable var secondColor: UIColor = UIColor.white {
		didSet {
			updateView()
		}
	}
	
	@IBInspectable var horizontalGradient: Bool = false {
		didSet {
			updateView()
		}
	}
	
	override public class var layerClass: AnyClass {
		get {
			return CAGradientLayer.self
		}
	}
	
	fileprivate func updateView() {
		let layer = self.layer as! CAGradientLayer
		layer.colors = [ firstColor.cgColor, secondColor.cgColor ]
		
		if (horizontalGradient) {
			layer.startPoint = CGPoint(x: 0.0, y: 0.5)
			layer.endPoint = CGPoint(x: 1.0, y: 0.5)
		} else {
			layer.startPoint = CGPoint(x: 0, y: 0)
			layer.endPoint = CGPoint(x: 0, y: 1)
		}
	}
	
}
