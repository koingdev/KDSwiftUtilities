//
//  OptionalX.swift
//  KDSwiftUtilities
//
//  Created by KoingDev on 2019/04/10.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {
	
	var orEmpty: Wrapped {
		return self ?? ""
	}
	
	var isNullOrEmpty: Bool {
		return self?.isEmpty ?? true
	}

}

extension Optional where Wrapped == Bool {
	
	var orTrue: Wrapped {
		return self ?? true
	}
	
	var orFalse: Wrapped {
		return self ?? false
	}
	
}

extension Optional {
	
	func or(_ other: @autoclosure () -> Wrapped?) -> Wrapped? {
		return self ?? other() ?? nil
	}
	
}
