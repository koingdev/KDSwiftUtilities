//
//  UIBezierPathX.swift
//  KDSwiftUtilities
//
//  Created by KoingDev on 2019/02/27.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import UIKit

extension UIBezierPath {
	
	/// Create a heart shape
	convenience init(heartIn rect: CGRect) {
		self.init()
		
		let x = rect.origin.x
		let y = rect.origin.y
		
		//Calculate Radius of Arcs using Pythagoras
		let sideOne = rect.width * 0.4
		let sideTwo = rect.height * 0.3
		let arcRadius = sqrt(sideOne * sideOne + sideTwo * sideTwo) / 2
		
		//Left Hand Curve
		addArc(withCenter: CGPoint(x: rect.width * 0.3 + x, y: rect.height * 0.35 + y), radius: arcRadius, startAngle: 135.degreesToRadians, endAngle: 315.degreesToRadians, clockwise: true)
		
		//Top Centre Dip
		addLine(to: CGPoint(x: rect.width / 2 + x, y: rect.height * 0.2 + y))
		
		//Right Hand Curve
		addArc(withCenter: CGPoint(x: rect.width * 0.7 + x, y: rect.height * 0.35 + y), radius: arcRadius, startAngle: 225.degreesToRadians, endAngle: 45.degreesToRadians, clockwise: true)
		
		//Right Bottom Line
		addLine(to: CGPoint(x: rect.width * 0.5 + x, y: rect.height * 0.95 + y))
		
		//Left Bottom Line
		close()
	}
	
}
