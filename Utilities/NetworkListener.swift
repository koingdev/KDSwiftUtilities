//
//  NetworkListener.swift
//  KDSwiftUtilities
//
//  Created by KoingDev on 2018/08/03.
//  Copyright © 2018 KoingDev. All rights reserved.
//
import Foundation
import Reachability

public protocol NetworkListener: AnyObject {

    /// Function to handle on network status changed
    ///
    /// - Parameter isEndPointReachable: flag
    func networkStatusDidChange(isEndPointReachable: Bool)

}

extension NetworkListener where Self: NSObject {
	
	func startMonitoring() {
		NotificationCenter.default.addObserver(forName: NetworkListenerHelper.notificationName, object: nil, queue: OperationQueue.main) { [weak self] notification in
			self?.networkStatusDidChange(isEndPointReachable: NetworkListenerHelper.instance.isEndPointReachable)
		}
	}
	
}

public final class NetworkListenerHelper {
    
    public static let instance = NetworkListenerHelper()
	fileprivate static let notificationName = Notification.Name("NetworkListenerHelperStatusDidChange")
	fileprivate let reachability: Reachability!
	var isEndPointReachable: Bool!
	
	static func enable() {
		_ = instance
	}
	
    private init() {
		guard let safeReachability = Reachability() else {
			reachability = Reachability()
			return
		}
		reachability = safeReachability
		// initialize connection state
		isEndPointReachable = reachability.connection != .none
		NotificationCenter.default.addObserver(forName: Notification.Name.reachabilityChanged,
											   object: nil,
											   queue: OperationQueue.main) { [weak self] notification in
			guard let self = self else { return }
			let newConnectionState = self.reachability.connection != .none
			if self.isEndPointReachable != newConnectionState {
				self.isEndPointReachable = newConnectionState
				NotificationCenter.default.post(name: NetworkListenerHelper.notificationName, object: nil)
			}
		}
		do {
			try reachability.startNotifier()
		} catch {
			debugPrint("Could not start reachability notifier")
		}
	}
    
}
