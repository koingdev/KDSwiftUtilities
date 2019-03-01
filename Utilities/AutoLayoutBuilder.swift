//
//  AutoLayoutBuilder.swift
//  KDWeddingGift
//
//  Created by KoingDev on 3/1/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import UIKit

struct AutoLayoutBuilder {
	
	let view: UIView
	
	init(_ view: UIView) {
		self.view = view
	}
	
	@discardableResult
	func topTo(_ anchor: NSLayoutYAxisAnchor, value: CGFloat = 0) -> AutoLayoutBuilder {
		view.topAnchor.constraint(equalTo: anchor, constant: value).isActive = true
		return self
	}
	
	@discardableResult
	func bottomTo(_ anchor: NSLayoutYAxisAnchor, value: CGFloat = 0) -> AutoLayoutBuilder {
		view.bottomAnchor.constraint(equalTo: anchor, constant: -value).isActive = true
		return self
	}
	
	@discardableResult
	func leadingTo(_ anchor: NSLayoutXAxisAnchor, value: CGFloat = 0) -> AutoLayoutBuilder {
		view.leadingAnchor.constraint(equalTo: anchor, constant: value).isActive = true
		return self
	}
	
	@discardableResult
	func trailingTo(_ anchor: NSLayoutXAxisAnchor, value: CGFloat = 0) -> AutoLayoutBuilder {
		view.trailingAnchor.constraint(equalTo: anchor, constant: -value).isActive = true
		return self
	}
	
	@discardableResult
	func centerXTo(_ anchor: NSLayoutXAxisAnchor, value: CGFloat = 0) -> AutoLayoutBuilder {
		view.centerXAnchor.constraint(equalTo: anchor, constant: value).isActive = true
		return self
	}
	
	@discardableResult
	func centerYTo(_ anchor: NSLayoutYAxisAnchor, value: CGFloat = 0) -> AutoLayoutBuilder {
		view.centerYAnchor.constraint(equalTo: anchor, constant: value).isActive = true
		return self
	}
	
	@discardableResult
	func centerInParent(_ view: UIView) -> AutoLayoutBuilder {
		centerXTo(view.centerXAnchor)
		centerYTo(view.centerYAnchor)
		return self
	}
	
	@discardableResult
	func width(value: CGFloat) -> AutoLayoutBuilder {
		view.widthAnchor.constraint(equalToConstant: value).isActive = true
		return self
	}
	
	@discardableResult
	func height(value: CGFloat) -> AutoLayoutBuilder {
		view.heightAnchor.constraint(equalToConstant: value).isActive = true
		return self
	}
	
	func build() {
		view.translatesAutoresizingMaskIntoConstraints = false
	}
	
}
