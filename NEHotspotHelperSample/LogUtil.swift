//
//  LogUtil.swift
//  NEHotspotHelperSample
//
//  Created by Daisuke T on 2019/01/08.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation



/**
 * log utility.
 */
class LogUtil
{
	// MARK: enum, const.
	// level
	private enum LEVEL : UInt
	{
		case DEV = 0
		case INF = 1
		case WAR = 2
		case ERR = 3
	}

	
	// MARK: method
	/**
	 * dev.
	 */
	static public func D(str: String?) -> Void {
		#if DEBUG
		Log(level:LEVEL.DEV, str:str)
		#endif
	}
	
	/**
	 * information.
	 */
	static public func I(str: String?) -> Void {
		Log(level:LEVEL.INF, str:str)
	}

	/**
	 * warning.
	 */
	static public func W(str: String?) -> Void {
		Log(level:LEVEL.WAR, str:str)
	}

	/**
	 * error.
	 */
	static public func E(str: String?) -> Void {
		Log(level:LEVEL.ERR, str:str)
	}

	/**
	 * output.
	 */
	static private func Log(level: LEVEL, str: String?) -> Void {

		let map:[LEVEL:String] = [
			LEVEL.DEV : "DEV",
			LEVEL.INF : "INF",
			LEVEL.WAR : "WAR",
			LEVEL.ERR : "ERR",
			]
		
		let levelStr = map[level]!
		
		let logStr = String(format: "[%@][%@][%@][%@][%d]%@",
							levelStr,
							Date().description,
							#file,
							#function,
							#line,
							str ?? "")
		
		print(logStr)
	}
}
