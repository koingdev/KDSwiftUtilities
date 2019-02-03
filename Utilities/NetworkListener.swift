//
//  NetworkListener.swift
//  KDSwiftUtilities
//
//  Created by KoingDev on 2018/08/03.
//  Copyright © 2018 KoingDev. All rights reserved.
//

import Foundation
import Reachability

final class NetworkListener {
    
	private let notification = Notification.Name("NetworkListenerStatusDidChanged")
	private let reachability: Reachability!
    /// Return true if connected to Internet
	private(set) var isConnected: Bool!
	
    init() {
		guard let safeReachability = Reachability() else {
			reachability = Reachability()
			return
		}
		reachability = safeReachability
		
		// initialize connection state
		isConnected = reachability.connection != .none
		
		NotificationCenter.default.addObserver(forName: Notification.Name.reachabilityChanged,
											   object: nil,
											   queue: OperationQueue.main) { [weak self] notification in
			guard let self = self else { return }
			let newConnectionState = self.reachability.connection != .none
			if self.isConnected != newConnectionState {
				self.isConnected = newConnectionState
				NotificationCenter.default.post(name: self.notification, object: nil)
			}
		}
		
		do {
			try reachability.startNotifier()
		} catch {
			dPrint("Could not start reachability notifier")
		}
	}
	
	/// Start monitoring network status changed
	///
	/// - Parameter networkStatusDidChange: status changed callback
	func observeNetworkStatusChanged(completion: @escaping (Bool) -> Void) {
		NotificationCenter.default.addObserver(forName: notification, object: nil, queue: OperationQueue.main) { [weak self] notification in
			guard let self = self else { return }
			completion(self.isConnected)
		}
	}
    
}
