//
//  AppDelegate.swift
//  NEHotspotHelperApp
//
//  Created by Daisuke T on 2019/01/08.
//  Copyright © 2019 test. All rights reserved.
//
		

import Foundation

import NetworkExtension

/**
 * refs
 * https://developer.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/Hotspot_Network_Subsystem_Guide/
 */
class HotspotHelperManager
{
	// MARK: singleton
	static let sharedInstance = HotspotHelperManager()
	private init() {
		// NOP
	}
	
	
	// MARK: member
	var _dataArray: [WiFiData] = []
	var _isEnabled:Bool = false
	
	
	
	// MARK: register
	func register() -> Void
	{
		let options: [String:NSString] = [
			kNEHotspotHelperOptionDisplayName:"NEHotspotHelper App"
		]
	
		NEHotspotHelper.register(options: options,
								 queue: DispatchQueue.main) { (command) in
									
									guard self._isEnabled else{
										return
									}

									
									self.Handle(command: command)
		}
	}
	
	
	
	// MARK: handle events.
	fileprivate func Handle(command:NEHotspotHelperCommand) -> Void
	{
		if command.commandType == .none
		{
			HandleOnNone(command: command)
		}
		else if command.commandType == .filterScanList
		{
			HandleOnFilterScanList(command: command)
		}
		else if command.commandType == .evaluate
		{
			HandleOnEvaluate(command: command)
		}
		else if command.commandType == .maintain
		{
			HandleOnMaintain(command: command)
		}
		else if command.commandType == .authenticate
		{
			HandleOnAuthenticate(command: command)
		}
		else if command.commandType == .presentUI
		{
			HandleOnPresentUI(command: command)
		}
		else if command.commandType == .logoff
		{
			HandleOnLogoff(command: command)
		}
	}
	
	/**
	 * Handle, "null" command.
	 */
	fileprivate func HandleOnNone(command:NEHotspotHelperCommand) -> Void
	{
		print("HandleOnNone")
	}

	/**
	 * Handle, Scan list.
	 *
	 * create network list for managed network.
	 *
	 * !attention!
	 * Do not set "NEHotspotHelperConfidence.high" other than managed network.
	 */
	fileprivate func HandleOnFilterScanList(command:NEHotspotHelperCommand) -> Void
	{
		print("HandleOnFilterScanList")

		// create network list for managed network.
		var array: [NEHotspotNetwork] = []
			
		for network in command.networkList ?? []
		{
			autoreleasepool
			{
				guard let index = _dataArray.index(of: WiFiData(network: network)) else {
					// unmanaged network.
					return
				}

				// managed network.
				print("add networklist [\(network)]")

				network.setPassword(_dataArray[index]._PW)
				network.setConfidence(NEHotspotHelperConfidence.high)
				
				array.append(network)
			}
		}
		
		
		// create response.
		let response = command.createResponse(NEHotspotHelperResult.success)
		
		if array.count > 0
		{
			// set network list when only there are managed network.
			response.setNetworkList(array)
		}
	
		response.deliver()
	}

	/**
	 * Handle, Evalute.
	 */
	fileprivate func HandleOnEvaluate(command:NEHotspotHelperCommand) -> Void
	{
		print("HandleOnEvaluate")

		guard let network:NEHotspotNetwork = command.network else {
			return
		}
		
		guard _dataArray.contains(WiFiData(network:network)) else{
			// unmanaged network.
			return
		}

		
		// managed network.
		print(network)

		network.setConfidence(NEHotspotHelperConfidence.high)
		
		
		let response = command.createResponse(NEHotspotHelperResult.success)
		response.setNetwork(network)
		response.deliver()
	}

	/**
	 * Handle, Maintain.
	 *
	 * This event is after second time connecting.
	 * connecting using cache.
	 */
	fileprivate func HandleOnMaintain(command:NEHotspotHelperCommand) -> Void
	{
		print("HandleOnMaintain")

		guard let network:NEHotspotNetwork = command.network else {
			return
		}
		
		guard _dataArray.contains(WiFiData(network:network)) else{
			// unmanaged network.
			return
		}
		
		
		// managed network.
		print(network)

		let response = command.createResponse(NEHotspotHelperResult.success)
		response.setNetwork(network)
		response.deliver()
	}

	/**
	 * Handle, Auth.
	 *
	 * Best match Helper's handle called whan after evalute.
	 */
	fileprivate func HandleOnAuthenticate(command:NEHotspotHelperCommand) -> Void
	{
		print("HandleOnAuthenticate")

		guard let network:NEHotspotNetwork = command.network else {
			return
		}
		
		guard _dataArray.contains(WiFiData(network:network)) else{
			// unmanaged network.
			return
		}
		
		
		// managed network.
		print(network)

		let response = command.createResponse(NEHotspotHelperResult.success)
		response.setNetwork(network)
		response.deliver()
	}

	/**
	 * Handle, UI present.
	 */
	fileprivate func HandleOnPresentUI(command:NEHotspotHelperCommand) -> Void
	{
		print("HandleOnPresentUI")
	}

	/**
	 * Handle, Logoff
	 */
	fileprivate func HandleOnLogoff(command:NEHotspotHelperCommand) -> Void
	{
		print("HandleOnLogoff")
	}
	
}
