//
//  UIControlClosure.swift
//  KDSwiftUtilities
//
//  Created by KoingDev on 5/1/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import UIKit

/**	Handle UIControl event closure-base instead of (target/action)

	Example:
	```swift
	// Button
	button.on(.touchUpInside) { btn in
		print("Button clicked")
	}
	// TextField
	textField.on(.editingChanged) { tf in
		print("Text changed")
	}
	```
*/
public protocol UIControlEventHandler: AnyObject { }

extension UIControl: UIControlEventHandler { }

// MARK: Associated Key

private struct AssociatedKeys {
	static var EventHandlers = "_EventHandlers"
}

// MARK: Implementation
public extension UIControlEventHandler where Self: UIControl {
	
	private var events: [UIControlEvent<Self>] {
		get {
			return (objc_getAssociatedObject(self, &AssociatedKeys.EventHandlers) as? [UIControlEvent<Self>]) ?? []
		}
		set {
			objc_setAssociatedObject(self, &AssociatedKeys.EventHandlers, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}
	
	public func on(_ events: UIControl.Event, closure: @escaping (Self) -> Void) {
		let handler = UIControlEvent<Self>(sender: self, events: events, closure: closure)
		self.events.append(handler)
	}
	
}

private final class UIControlEvent<Sender: UIControl>: NSObject {
	
	let closure: (Sender) -> Void
	
	init(sender: Sender, events: UIControl.Event, closure: @escaping (Sender) -> Void) {
		self.closure = closure
		super.init()
		
		sender.addTarget(self, action: #selector(self.action), for: events)
	}
	
	@objc private func action(sender: UIControl) {
		guard let sender = sender as? Sender else { return }
		
		self.closure(sender)
	}
	
}
