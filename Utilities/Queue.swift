//
//  Queue.swift
//  KDSwiftUtilities
//
//  Created by KoingDev on 2019/02/01.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import Foundation

final class Queue {
	
	static let background = DispatchQueue(label: "kd.queue.background")
	
	static func runAfter(_ delay: Double, completion: @escaping () -> Void) {
		DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: completion)
	}
	
	static func main(completion: @escaping () -> Void) {
		DispatchQueue.main.async(execute: completion)
	}
	
	static func mainSync(completion: @escaping () -> Void) {
		DispatchQueue.main.sync(execute: completion)
	}
	
	static func background(completion: @escaping () -> Void) {
		background.async(execute: completion)
	}
	
}
