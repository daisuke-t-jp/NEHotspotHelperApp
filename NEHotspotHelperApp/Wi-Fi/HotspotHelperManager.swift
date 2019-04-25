//
//  HotspotHelperManager.swift
//  NEHotspotHelperApp
//
//  Created by Daisuke T on 2019/01/08.
//  Copyright © 2019 Daisuke T. All rights reserved.
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

  
  
  // MARK: member
  var hotspots: [Hotspot] = []
  var isEnabled: Bool = false
  
  
  
  // MARK: register
  func register(_ displayName: String) -> Void
  {
	  let options: [String:NSString] = [
  	  kNEHotspotHelperOptionDisplayName: displayName as NSString
	  ]
  
	  NEHotspotHelper.register(options: options,
	  	  	  	   queue: DispatchQueue.main) { (command) in
  	  	  	  	  
  	  	  	  	  guard self.isEnabled else{
	  	  	  	  	  return
  	  	  	  	  }

  	  	  	  	  
  	  	  	  	  self.handle(command: command)
	  }
  }
  
  
  
  // MARK: handle events.
  fileprivate func handle(command: NEHotspotHelperCommand) -> Void
  {
	  if command.commandType == .none
	  {
  	  handleOnNone(command: command)
	  }
	  else if command.commandType == .filterScanList
	  {
  	  handleOnFilterScanList(command: command)
	  }
	  else if command.commandType == .evaluate
	  {
  	  handleOnEvaluate(command: command)
	  }
	  else if command.commandType == .maintain
	  {
  	  handleOnMaintain(command: command)
	  }
	  else if command.commandType == .authenticate
	  {
  	  handleOnAuthenticate(command: command)
	  }
	  else if command.commandType == .presentUI
	  {
  	  handleOnPresentUI(command: command)
	  }
	  else if command.commandType == .logoff
	  {
  	  handleOnLogoff(command: command)
	  }
  }
  
  /**
   * handle, "null" command.
   */
  fileprivate func handleOnNone(command: NEHotspotHelperCommand) -> Void
  {
	  print("handleOnNone")
  }

  /**
   * handle, Scan list.
   *
   * create network list for managed network.
   *
   * !attention!
   * Do not set "NEHotspotHelperConfidence.high" other than managed network.
   */
  fileprivate func handleOnFilterScanList(command: NEHotspotHelperCommand) -> Void
  {
	  print("handleOnFilterScanList")

	  // create network list for managed network.
	  var array: [NEHotspotNetwork] = []
  	  
	  for network in command.networkList ?? []
	  {
  	  autoreleasepool
  	  {
	  	  guard let index = hotspots.index(of: Hotspot(network: network)) else {
  	  	  // unmanaged network.
  	  	  return
	  	  }

	  	  // managed network.
	  	  print("add networklist [\(network)]")

	  	  network.setPassword(hotspots[index].pw)
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
   * handle, Evalute.
   */
  fileprivate func handleOnEvaluate(command:NEHotspotHelperCommand) -> Void
  {
	  print("handleOnEvaluate")

	  guard let network: NEHotspotNetwork = command.network else {
  	  return
	  }

	  guard hotspots.contains(Hotspot(network: network)) else{
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
   * handle, Maintain.
   *
   * This event is after second time connecting.
   * connecting using cache.
   */
  fileprivate func handleOnMaintain(command:NEHotspotHelperCommand) -> Void
  {
	  print("handleOnMaintain")

	  guard let network: NEHotspotNetwork = command.network else {
  	  return
	  }
	  
	  guard hotspots.contains(Hotspot(network: network)) else{
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
   * handle, Auth.
   *
   * Best match Helper's handle called whan after evalute.
   */
  fileprivate func handleOnAuthenticate(command: NEHotspotHelperCommand) -> Void
  {
	  print("handleOnAuthenticate")

	  guard let network:NEHotspotNetwork = command.network else {
  	  return
	  }
	  
	  guard hotspots.contains(Hotspot(network: network)) else{
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
   * handle, UI present.
   */
  fileprivate func handleOnPresentUI(command: NEHotspotHelperCommand) -> Void
  {
	  print("handleOnPresentUI")
  }

  /**
   * handle, Logoff
   */
  fileprivate func handleOnLogoff(command: NEHotspotHelperCommand) -> Void
  {
	  print("handleOnLogoff")
  }
  
}
