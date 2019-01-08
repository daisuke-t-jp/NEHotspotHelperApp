//
//  WiFiData.swift
//  NEHotspotHelperApp
//
//  Created by 外崎大輔 on 2019/01/08.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation

import NetworkExtension

class WiFiData : Equatable
{
	// MARK: enum, const
	enum AuthType: UInt
	{
		case WEP = 0
		case WPA = 1	// WPA/WPA2
	}
	
	
	// MARK: member
	var _BSSID:String
	var _SSID:String
	var _PW:String
	var _authType:AuthType

	
	// MARK: life-cycle
	init()
	{
		_BSSID = ""
		_SSID = ""
		_PW = ""
		_authType = AuthType.WEP
	}

	init(network:NEHotspotNetwork)
	{
		_BSSID = network.bssid
		_SSID = network.ssid
		_PW = ""
		_authType = AuthType.WEP;
	}
	
	
	// MARK: override
	static func ==(lhs: WiFiData, rhs: WiFiData) -> Bool{
		
		if lhs._BSSID.count > 0 && rhs._BSSID.count > 0
		{
			// BSSID is not empty.
			// -> compare BSSID.
			return lhs._BSSID.caseInsensitiveCompare(rhs._BSSID) == .orderedSame
		}
		
		// compare SSID.
		return lhs._SSID.caseInsensitiveCompare(rhs._SSID) == .orderedSame
	}
	
	var description: String {
		let res = String(format: "BSSID[%@] SSID[%@",
						 _BSSID,
						 _SSID
		)
		
		return res
	}
}
