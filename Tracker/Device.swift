//
//  Device.swift
//  Tracker
//
//  Created by Marc Dermejian on 15/12/2016.
//  Copyright © 2016 Marc Dermejian. All rights reserved.
//

import Foundation
import Alamofire
import Commons
import SwiftCommons

struct Device: CustomStringConvertible, ResponseObjectSerializable, ResponseCollectionSerializable {

	// MARK: - stored properties
	
	var id: Int?
	var device: String?
	var os: String?
	var manufacturer: String?
	var isCheckedOut: Bool?
	var lastCheckedOutDate: Date?
	var lastCheckedOutBy: String?
	

	// MARK: - ResponseObjectSerializable protocol implementation
	
	fileprivate typealias Fields = DeviceKey
	fileprivate typealias Value = AnyObject
	
	init?(response: HTTPURLResponse, representation: Any) {
		
		guard let representation = representation as? [String: AnyObject] else { return nil }
		
		if let id = representation[Fields.ID.rawValue] as? NSNumber { self.id = id.intValue }
		if let device = representation[Fields.Device.rawValue] as? String { self.device = device }
		if let os = representation[Fields.OS.rawValue] as? String { self.os = os }
		if let manufacturer = representation[Fields.Manufacturer.rawValue] as? String { self.manufacturer = manufacturer }
		if let isCheckedOut = representation[Fields.CheckedOut.rawValue] as? Bool { self.isCheckedOut = isCheckedOut }
		if let lastCheckedOutDate = representation[Fields.LastCheckedOutDate.rawValue] as? String { self.lastCheckedOutDate = NSDate(fromRFC3339String: lastCheckedOutDate) as Date }
		if let lastCheckedOutBy = representation[Fields.LastCheckedOutBy.rawValue] as? String{ self.lastCheckedOutBy = lastCheckedOutBy }
	}
}

// MARK: - API Keys

// The keys to the values received in the API response
// These do not represent the entirety of the response
// we are only choosing a select few to parse and store
public enum DeviceKey: String {
	
	case ID						= "id"
	case Device					= "device"
	case OS						= "os"
	case Manufacturer			= "manufacturer"
	case CheckedOut				= "isCheckedOut"
	case LastCheckedOutDate		= "lastCheckedOutDate"
	case LastCheckedOutBy		= "lastCheckedOutBy"
}
