//
//  Hotspot.swift
//  NEHotspotHelperApp
//
//  Created by Daisuke T on 2019/01/08.
//  Copyright © 2019 Daisuke T. All rights reserved.
//

import Foundation

import NetworkExtension



class Hotspot : Equatable
{
	// MARK: enum, const
	enum AuthType: UInt
	{
		case WEP = 0
		case WPA = 1	// WPA/WPA2
	}
	
	
	// MARK: Member
	var bssid: String
	var ssid: String
	var pw: String
	var authType: AuthType

	
	// MARK: Life cycle
	init()
	{
		bssid = ""
		ssid = ""
		pw = ""
		authType = AuthType.WEP
	}

	init(network: NEHotspotNetwork)
	{
		bssid = network.bssid
		ssid = network.ssid
		pw = ""
		authType = AuthType.WEP
	}
	
	
	// MARK: override
	static func ==(lhs: Hotspot, rhs: Hotspot) -> Bool{
		
		if lhs.bssid.count > 0 && rhs.bssid.count > 0
		{
			// BSSID is not empty.
			// -> compare BSSID.
			return lhs.bssid.caseInsensitiveCompare(rhs.bssid) == .orderedSame
		}
		
		// compare SSID.
		return lhs.ssid.caseInsensitiveCompare(rhs.ssid) == .orderedSame
	}
	
	var description: String {
		let res = String(format: "BSSID[%@] SSID[%@",
						 bssid,
						 ssid
		)
		
		return res
	}
}
