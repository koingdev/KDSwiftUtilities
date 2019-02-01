//
//  Helper.swift
//  KDSwiftUtilities
//
//  Created by KoingDev on 2019/02/01.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import Foundation

func dPrint(_ item: Any) {
	#if DEBUG
		Swift.print("DEBUG: \(item)\n")
	#endif
}

