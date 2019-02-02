//
//  Helper.swift
//  KDSwiftUtilities
//
//  Created by KoingDev on 2019/02/01.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import Foundation
import UIKit.UIApplication
import UserNotifications

////////////////////////////////////////////////////////////////
//MARK: -
//MARK: Helper Methods
//MARK: -
////////////////////////////////////////////////////////////////

func dPrint(_ item: Any) {
	#if DEBUG
		Swift.print("DEBUG: \(item)\n")
	#endif
}

/// Check if user allows push notification or not
///
/// - Parameter completion: Result callback (Background Thread).
///                            Make sure to do UI-related tasks on Main Thread.
func isUserAllowPushNotification(completion: @escaping (Bool) -> Void) {
    if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            let isUserAllow: Bool
            switch settings.authorizationStatus {
            case .notDetermined, .denied:
                isUserAllow = false
            case .authorized:
                isUserAllow = true
            default:
                isUserAllow = false
            }
            completion(isUserAllow)
        }
    } else {
        // Fallback on earlier versions
        if let notificationType = UIApplication.shared.currentUserNotificationSettings?.types {
            let isUserAllow = !notificationType.isEmpty
            completion(isUserAllow)
        } else {
            completion(false)
        }
    }
}
