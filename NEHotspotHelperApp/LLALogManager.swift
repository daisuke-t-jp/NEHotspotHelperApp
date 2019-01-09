//
//  LLALogManager.swift
//  LLALogManager
//
//  Created by Daisuke T on 2019/01/09.
//  Copyright © 2019 Daisuke T. All rights reserved.
//

import Foundation



class LLALogManager
{

	// MARK: singleton
	static let sharedInstance = LLALogManager()
	

	// MARK: enum, const.
	private enum LEVEL : UInt
	{
		case DEV
		case INF
		case WAR
		case ERR
	}
	
	static let SEPARATOR_DEFAULT: String = " "
	
	
	// MARK: member
	var separator:String = LLALogManager.SEPARATOR_DEFAULT
	
	
	// MARK: life-cycle
	private init()
	{
		// NOP
	}
	

	// MARK: method
	func d(_ items: Any..., file: String = #file, function: String = #function, line: Int = #line) -> Void {
		#if DEBUG
		log(LEVEL.DEV, items: items, file: file, function: function, line: line)
		#endif
	}
	
	func i(_ items: Any..., file: String = #file, function: String = #function, line: Int = #line) -> Void {
		log(LEVEL.INF, items: items, file: file, function: function, line: line)
	}

	func w(_ items: Any..., file: String = #file, function: String = #function, line: Int = #line) -> Void {
		log(LEVEL.WAR, items: items, file: file, function: function, line: line)
	}

	func e(_ items: Any..., file: String = #file, function: String = #function, line: Int = #line) -> Void {
		log(LEVEL.ERR, items: items, file: file, function: function, line: line)
	}
	
	private func log(_ level: LEVEL, items:[Any], file: String, function: String, line: Int) -> Void {
		
		let map:[LEVEL:String] = [
			LEVEL.DEV : "DEV",
			LEVEL.INF : "INF",
			LEVEL.WAR : "WAR",
			LEVEL.ERR : "ERR",
			]

		let levelStr = map[level]!

		
		/**
		 * print prefix.
		 */
		let fileName: String = NSString(string:file).lastPathComponent
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
		let date = dateFormatter.string(from: Date())
		
		print("\(date) \(levelStr) \(fileName) \(function):\(line) ",
			terminator: "")

		
		/**
		 * print items.
		 */
		var separator = ""
		for elm in items
		{
			print(separator, terminator: "")
			print(elm, terminator: "")
			
			separator = self.separator
		}
		
		print("")

	}
}
