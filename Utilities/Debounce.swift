//
//  Debounce.swift
//  KDSwiftUtilities
//
//  Created by KoingDev on 5/1/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import Foundation

/// Return a new function that will be called only once after `delay` time passed between invocation
func debounce(delay: TimeInterval, queue: DispatchQueue = .main, function: @escaping () -> Void) -> () -> Void {
	var currentWorkItem: DispatchWorkItem?
	return {
		currentWorkItem?.cancel()
		currentWorkItem = DispatchWorkItem { function() }
		queue.asyncAfter(deadline: .now() + delay, execute: currentWorkItem!)
	}
}
