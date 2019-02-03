//
//  View.swift
//  SwiftUtilities
//
//  Created by KoingDev on 2/2/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import UIKit

private var gradientFirstColorAssociationKey: UInt8 = 0
private var gradientSecondColorAssociationKey: UInt8 = 0
private var gradientHorizontalAssociationKey: UInt8 = 0

extension UIView {
    
    // MARK: - Gradient
    
    fileprivate func applyGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [firstColor.cgColor, secondColor.cgColor]
        if horizontalGradient {
            gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        } else {
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 0, y: 1)
        }
        layer.addSublayer(gradient)
    }
    
    @IBInspectable var firstColor: UIColor {
        get {
            let firstColor = objc_getAssociatedObject(self, &gradientFirstColorAssociationKey) as? UIColor
            return firstColor ?? UIColor.clear
        }
        set {
            objc_setAssociatedObject(self, &gradientFirstColorAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
            applyGradient()
        }
    }

    @IBInspectable var secondColor: UIColor {
        get {
            let secondColor = objc_getAssociatedObject(self, &gradientSecondColorAssociationKey) as? UIColor
            return secondColor ?? UIColor.clear
        }
        set {
            objc_setAssociatedObject(self, &gradientSecondColorAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
            applyGradient()
        }
    }

    @IBInspectable var horizontalGradient: Bool {
        get {
            let horizontalGradient = objc_getAssociatedObject(self, &gradientHorizontalAssociationKey) as? Bool
            return horizontalGradient ?? false
        }
        set {
            objc_setAssociatedObject(self, &gradientHorizontalAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
            applyGradient()
        }
    }
    
    // MARK: - Border
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    // MARK: - Shadow
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowColor: UIColor {
        get {
            return UIColor(cgColor: layer.shadowColor ?? UIColor.clear.cgColor)
        }
        set {
            layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var shadowOffsetY: CGFloat {
        get {
            return layer.shadowOffset.height
        }
        set {
            layer.shadowOffset.height = newValue
        }
    }
    
}

// MARK: Animation

extension UIView {
    
    enum ShakeDirection {
        case horizontal
        case vertical
    }
    
    func shake(direction: ShakeDirection = .horizontal, duration: TimeInterval = 0.8, completion: (() -> Void)? = nil) {
        CATransaction.begin()
        let animation: CAKeyframeAnimation
        switch direction {
        case .horizontal:
            animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        case .vertical:
            animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        }
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        CATransaction.setCompletionBlock(completion)
        animation.duration = duration
        animation.values = [-15.0, 15.0, -15.0, 15.0, -10.0, 10.0, -5.0, 5.0, 0.0]
        layer.add(animation, forKey: "shake")
        CATransaction.commit()
    }
    
    func popIn(duration: TimeInterval = 0.8, completion: (() -> Void)? = nil) {
        transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: { _ in
            completion?()
        })
    }
    
    func rotate(byAngle angle: CGFloat, animated: Bool = false, duration: TimeInterval = 0.8, completion: (() -> Void)? = nil) {
        let angle = .pi * angle / 180.0
        let duration = animated ? duration : 0
        UIView.animate(withDuration: duration, delay: 0, options: [.curveLinear, .allowUserInteraction], animations: { () -> Void in
            self.transform = self.transform.rotated(by: angle)
        }, completion: { _ in
            completion?()
        })
    }
    
    func scale(by offset: CGPoint, animated: Bool = false, duration: TimeInterval = 0.8, completion: (() -> Void)? = nil) {
        if animated {
            UIView.animate(withDuration: duration, delay: 0, options: [.curveLinear, .allowUserInteraction], animations: { () -> Void in
                self.transform = self.transform.scaledBy(x: offset.x, y: offset.y)
            }, completion: { _ in
                completion?()
            })
        } else {
            transform = transform.scaledBy(x: offset.x, y: offset.y)
            completion?()
        }
    }
    
    func fadeIn(duration: TimeInterval = 0.8, completion: (() -> Void)? = nil) {
        alpha = 0
        UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.alpha = 1
        }, completion: { _ in
            completion?()
        })
    }
    
    func fadeOut(duration: TimeInterval = 0.8, completion: (() -> Void)? = nil) {
        alpha = 1
        UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.alpha = 0
        }, completion: { _ in
            completion?()
        })
    }
    
}

// MARK: Auto Layout Extension

extension UIView {
    
    func fillSuperview() {
        anchor(top: superview?.topAnchor, bottom: superview?.bottomAnchor, leading: superview?.leadingAnchor, trailing: superview?.trailingAnchor)
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, margin: UIEdgeInsets = .zero, size: CGSize = .zero) {
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: margin.top).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -margin.bottom).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: margin.left).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -margin.right).isActive = true
        }
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
}
