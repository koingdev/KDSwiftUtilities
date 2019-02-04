//
//  UIViewControllerX.swift
//  KDSwiftUtilities
//
//  Created by KoingDev on 2018/08/03.
//  Copyright © 2018 KoingDev. All rights reserved.
//

import UIKit

////////////////////////////////////////////////////////////////
//MARK: -
//MARK: Storyboarder (Easy way to instantiates ViewController)
//MARK: -
////////////////////////////////////////////////////////////////

protocol Storyboarder {
    
    static var storyboardName: String { get }
    static var storyboardIdentifier: String { get }
    
}

extension Storyboarder where Self: UIViewController {
    
    static var storyboardName: String {
        return String(describing: self)
    }
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    /// Instantiates and returns the view controller
    ///
    /// - Returns: View controller corresponding to the specified identifier string
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
		// Is Initial View Controller ?
		if let vc = storyboard.instantiateInitialViewController() as? Self {
			return vc
		}
		// Use Storyboard Identifier = Class Name
        guard let vc = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as? Self else {
            fatalError("Failed to instantiate \(storyboardName)")
        }
        return vc
    }
    
}

////////////////////////////////////////////////////////////////
//MARK: -
//MARK: UIViewController
//MARK: -
////////////////////////////////////////////////////////////////

extension UIViewController: Storyboarder {
    
    public func add(childVC: UIViewController, to wrapper: UIView) {
		addChild(childVC)
        wrapper.addSubview(childVC.view)
        childVC.view.frame = wrapper.bounds
		childVC.didMove(toParent: self)
    }
    
    public func remove() {
        guard parent != nil else { return }
		willMove(toParent: nil)
		removeFromParent()
        view.removeFromSuperview()
    }
    
    /// Return the top most view controller
    public static var topMostViewController: UIViewController {
        return UIApplication.shared.keyWindow?.rootViewController?.topMostViewController ?? UIViewController()
    }
    
    private var topMostViewController: UIViewController {
        if let vc = presentedViewController {
            return vc.topMostViewController
        }
        if let navigation = self as? UINavigationController {
            if let visible = navigation.visibleViewController {
                return visible.topMostViewController
            }
        }
        if let tab = self as? UITabBarController {
            if let selected = tab.selectedViewController {
                return selected.topMostViewController
            }
            return tab.topMostViewController
        }
        return self
    }
        
}
