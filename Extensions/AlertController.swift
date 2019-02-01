//
//  AlertController.swift
//  KDSwiftUtilities
//
//  Created by KoingDev on 2018/08/03.
//  Copyright © 2018 KoingDev. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    // MARK: - Typealias
    
    public typealias Alert = UIAlertController
    public typealias Action = UIAlertAction
    public typealias Handler = ((Action) -> Void)?
    
    // MARK: - Static function
    
    public static func alertOkay(title: String, message: Any = "", handler: Handler = nil) {
        UIAlertController.Builder()
            .withTitleAndMessage(title: title, message: message)
            .addOkAction(handler)
            .show()
    }
    
    public static func alertTextField(title: String,
                                      numberOfField: Int = 1,
                                      placeholders: [String] = [],
                                      isSecureTexts: [Bool] = [],
                                      message: Any = "",
                                      then: (([String]) -> Void)? = nil) {
        let builder = UIAlertController.Builder()
        builder.withTitleAndMessage(title: title, message: message)
			.addOkCancelAction(okayHandler: { _ in
				guard let then = then else { return }
				var texts = [String]()
				builder.alert.textFields?.forEach { texts.append($0.text ?? "") }
				then(texts)
				builder.alert = nil    // Avoid retain cycle
			}, cancelHandler: { _ in builder.alert = nil })
			.addTextField(numberOfField: numberOfField, placeholders: placeholders, isSecureTexts: isSecureTexts)
			.show()
    }
    
    // MARK: - Builder
    
	class Builder {
        
        private var alert: Alert! = Alert(title: "", message: "", preferredStyle: .alert)
		
		enum ActionType: CaseIterable {
			case ok
			case cancel
			case custom
		}
		
        @discardableResult
		func withTitleAndMessage(title: String = "Title", message: Any = "Message") -> Self {
			alert.title = title
			if let message = message as? String {
				alert.message = message
			}
			if let attributedMessage = message as? NSAttributedString {
				alert.setValue(attributedMessage, forKey: "attributedMessage")
			}
            return self
        }
		
		func addActions(_ actionTypes: (ActionType, ActionType), completion: @escaping () -> Void) -> Self {
			// Aux functions
			func setAction(title: String, style: UIAlertAction.Style = .default, completion: @escaping () -> Void) {
				let action = Action(title: title, style: .cancel) { _ in
					completion()
				}
				alert.addAction(action)
			}
			func apply(actionType: ActionType) {
				switch actionType {
				case .ok:
					setAction(title: "Okay", completion: completion)
				case .cancel:
					setAction(title: "Cancel", style: .cancel, completion: completion)
				case .custom:
					
				}
			}
		}
        
        @discardableResult
        public func addOkAction(_ handler: Handler = nil) -> Self {
            let title = "Okay"
            let action = Action(title: title, style: .default, handler: handler)
            alert.addAction(action)
            return self
        }
        
        @discardableResult
        public func addCancelAction(_ handler: Handler = nil) -> Self {
            let title = "Cancel"
            let action = Action(title: title, style: .cancel, handler: handler)
            alert.addAction(action)
            return self
        }
        
        @discardableResult
        public func addOkCancelAction(okayHandler: Handler = nil, cancelHandler: Handler = nil) -> Self {
            return addOkAction(okayHandler).addCancelAction(cancelHandler)
        }
        
        @discardableResult
		public func addCustomAction(_ title: String, style: UIAlertAction.Style = .default, _ handler: Handler = nil) -> Self {
            let action = Action(title: title, style: style, handler: handler)
            alert.addAction(action)
            return self
        }
        
        @discardableResult
        public func addTextField(numberOfField: Int = 1,
                                 placeholders: [String?] = [],
                                 isSecureTexts: [Bool?] = []) -> Self {
            for i in 0 ..< numberOfField {
                alert.addTextField { tf in
                    if placeholders.count == numberOfField {
                        tf.placeholder = placeholders[i]
                    }
                    if isSecureTexts.count == numberOfField {
                        tf.isSecureTextEntry = isSecureTexts[i] ?? false
                    }
                }
            }
            return self
        }
        
        public func show(then: (() -> Void)? = nil) {
            UIViewController.topMostViewController.present(alert, animated: true, completion: then)
        }
        
    }
    
}
