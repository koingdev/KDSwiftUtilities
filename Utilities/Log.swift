//
//  Log.swift
//  KDSwiftUtilities
//
//  Created by KoingDev on 2019/02/04.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import Foundation

func dPrint(_ item: Any) {
	#if DEBUG
		Swift.print(item)
	#endif
}

final class Log {
	
	private enum LogType: String {
		case error = "[⛔️]"
		case debug = "[ℹ️]"
		case warning = "[⚠️]"
	}
	
	private static func sourceFileName(filePath: String) -> String {
		let fileName = filePath.components(separatedBy: "/").last
		return fileName ?? ""
	}
	
	static func error(_ object: Any,
					  fileName: String = #file,
					  line: Int = #line,
					  funcName: String = #function) {
		dPrint("Log: \(LogType.error.rawValue) [\(sourceFileName(filePath: fileName))] [Line: \(line)] \(funcName) -> \(object)")
	}
	
	static func debug(_ object: Any,
					  fileName: String = #file,
					  line: Int = #line,
					  funcName: String = #function) {
		dPrint("Log: \(LogType.debug.rawValue) [\(sourceFileName(filePath: fileName))] [Line: \(line)] \(funcName) -> \(object)")
	}
	
	static func warning(_ object: Any,
						fileName: String = #file,
						line: Int = #line,
						funcName: String = #function) {
		dPrint("Log: \(LogType.warning.rawValue) [\(sourceFileName(filePath: fileName))] [Line: \(line)] \(funcName) -> \(object)")
	}
	
}
