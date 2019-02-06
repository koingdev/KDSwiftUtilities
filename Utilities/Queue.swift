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
		let deadline = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
		DispatchQueue.main.asyncAfter(deadline: deadline, execute: completion)
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
