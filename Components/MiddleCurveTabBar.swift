//
//  MiddleCurveTabBar.swift
//  KDWeddingGift
//
//  Created by KoingDev on 2/8/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import UIKit

extension CGFloat {
	var degreesToRadians: CGFloat { return self * .pi / 180 }
	var radiansToDegrees: CGFloat { return self * 180 / .pi }
}

@IBDesignable
class MiddleCurveTabBar: UITabBar {
	
	private var shapeLayer: CALayer?
	private let buttonRadius: CGFloat = 30
	
	override func draw(_ rect: CGRect) {
		addShape()
	}
	
	override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
		return abs(center.x - point.x) > buttonRadius || abs(point.y) > buttonRadius
	}
	
	private func addShape() {
		let shapeLayer = CAShapeLayer()
		shapeLayer.path = createCirclePath()
		shapeLayer.strokeColor = UIColor.lightGray.cgColor
		shapeLayer.fillColor = UIColor.white.cgColor
		shapeLayer.lineWidth = 1.0
		
		if let oldShapeLayer = self.shapeLayer {
			layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
		} else {
			layer.insertSublayer(shapeLayer, at: 0)
		}
		
		self.shapeLayer = shapeLayer
	}
	
	// MARK: - Shapes
	
	func createCurvePath() -> CGPath {
		let height: CGFloat = buttonRadius + 3
		let path = UIBezierPath()
		let centerWidth = frame.width / 2
		
		path.move(to: CGPoint(x: 0, y: 0)) // start top left
		path.addLine(to: CGPoint(x: (centerWidth - height * 2), y: 0)) // the beginning of the trough
		// first curve down
		path.addCurve(to: CGPoint(x: centerWidth, y: height),
					  controlPoint1: CGPoint(x: (centerWidth - 30), y: 0), controlPoint2: CGPoint(x: centerWidth - 35, y: height))
		// second curve up
		path.addCurve(to: CGPoint(x: (centerWidth + height * 2), y: 0),
					  controlPoint1: CGPoint(x: centerWidth + 35, y: height), controlPoint2: CGPoint(x: (centerWidth + 30), y: 0))
		
		// complete the rect
		path.addLine(to: CGPoint(x: frame.width, y: 0))
		path.addLine(to: CGPoint(x: frame.width, y: frame.height))
		path.addLine(to: CGPoint(x: 0, y: frame.height))
		path.close()
		
		return path.cgPath
	}
	
	func createCirclePath() -> CGPath {
		let radius: CGFloat = buttonRadius + 3
		let path = UIBezierPath()
		let centerWidth = frame.width / 2
		
		path.move(to: CGPoint(x: 0, y: 0))
		path.addLine(to: CGPoint(x: (centerWidth - radius * 2), y: 0))
		path.addArc(withCenter: CGPoint(x: centerWidth, y: 0), radius: radius, startAngle: CGFloat(180).degreesToRadians, endAngle: CGFloat(0).degreesToRadians, clockwise: false)
		path.addLine(to: CGPoint(x: frame.width, y: 0))
		path.addLine(to: CGPoint(x: frame.width, y: frame.height))
		path.addLine(to: CGPoint(x: 0, y: frame.height))
		path.close()
		return path.cgPath
	}
	
}
