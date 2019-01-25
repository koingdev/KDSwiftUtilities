//
//  EmojiString.swift
//  KDSwiftUtilities
//
//  Created by KoingDev on 8/25/18.
//  Copyright © 2018 KoingDev. All rights reserved.
//

import Foundation

extension NSObject {
    
    public var emojiString: String {
        let pointer = Unmanaged.passUnretained(self).toOpaque()
        // You can adjust your range
        //let range = 0x1F600...0x1F64F
        let range = 0x1F300...0x1F3F0
        let index = (pointer.hashValue % range.count)
        let ord = range.lowerBound + index
        guard let scalar = UnicodeScalar(ord) else { return "❓" }
        return String(scalar)
    }
    
}
