//
//  UIComponentStyler.swift
//  KDSwiftUtilities
//
//  Created by KoingDev on 3/1/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import UIKit

/**
Flexible and faster way to style your View

Example:
```swift
let label = UILabel()
label.styling(UIColor.blue.style, UIFont.boldSystemFont(ofSize: 18).style)
```
*/
protocol UIComponentStyler: AnyObject {
	var styleFont: UIFont! { get set }
	var styleTextColor: UIColor! { get set }
}

extension UIComponentStyler {
	func styling(_ styles: UIComponentStyle...) {
		for style in styles {
			style.styling(self)
		}
	}
}

////////////////////////////////////////////////////////////////
//MARK: -
//MARK: Style (Color, Font, ...)
//MARK: -
////////////////////////////////////////////////////////////////

struct UIComponentStyle {
	/// Apply style to UIView
	let styling: (UIComponentStyler) -> Void
}

extension UIColor {
	var style: UIComponentStyle {
		return UIComponentStyle { $0.styleTextColor = self }
	}
}

extension UIFont {
	var style: UIComponentStyle {
		return UIComponentStyle { $0.styleFont = self }
	}
}

// More style to add here...

////////////////////////////////////////////////////////////////
//MARK: -
//MARK: Implement UIComponentStyler (on UIKit)
//MARK: -
////////////////////////////////////////////////////////////////

extension UILabel: UIComponentStyler {
	
	var styleFont: UIFont! {
		get { return font }
		set { font = newValue }
	}
	
	var styleTextColor: UIColor! {
		get { return textColor }
		set { textColor = newValue }
	}
	
}

extension UITextField: UIComponentStyler {
	
	var styleFont: UIFont! {
		get { return font ?? UIFont() }
		set { font = newValue }
	}
	
	var styleTextColor: UIColor! {
		get { return textColor ?? UIColor.black }
		set { textColor = newValue }
	}
	
}

// More component to add here...
