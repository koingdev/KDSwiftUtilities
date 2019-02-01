//
//  Queue.swift
//  KDSwiftUtilities
//
//  Created by KoingDev on 2019/02/01.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import Foundation

final class Queue {
	
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
		DispatchQueue(label: "kd.queue.background").async(execute: completion)
	}
	
}
