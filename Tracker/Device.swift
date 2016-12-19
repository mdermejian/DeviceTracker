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

final class Device: NSObject, ResponseObjectSerializable, ResponseCollectionSerializable, JSONAble, NSCoding {

	// MARK: - stored properties
	
	var id: Int?
	var device: String?
	var os: String?
	var manufacturer: String?
	var isCheckedOut: Bool?
	var lastCheckedOutDate: Date?
	var lastCheckedOutBy: String?
	
	var syncStatus: SyncStatus = .none
	
	//MARK: Archiving Paths
 
	static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
	static let ArchiveURL = DocumentsDirectory.appendingPathComponent("devices")
	
	// Mark: - computed properties
	var status: String {
		guard let isCheckedOut = isCheckedOut else { return "Available" }
		
		if !isCheckedOut {
			return "Available"
		}
		
		if let lastCheckedOutBy = lastCheckedOutBy {
			return "Checked out by \(lastCheckedOutBy)"
		}else {
			return "Checked out"
		}
	}
	
	var deviceInfo: String {
		var info = ""
		if manufacturer != nil {
			info += "\(manufacturer!) "
		}
		if device != nil {
			info += "\(device!)"
		}
		return info
	}

	// Mark: - init
	init(device: String, os: String, manufacturer: String) {
		self.device = device
		self.os = os
		self.manufacturer = manufacturer
		self.isCheckedOut = false
	}
	
	// MARK: - ResponseObjectSerializable protocol implementation
	
	fileprivate typealias Fields = DeviceKey
	fileprivate typealias Value = AnyObject
	
	required init?(response: HTTPURLResponse, representation: Any) {
		
		guard let representation = representation as? [String: AnyObject] else { return nil }
		
		if let id = representation[Fields.ID] as? NSNumber { self.id = id.intValue }
		if let device = representation[Fields.Device] as? String { self.device = device }
		if let os = representation[Fields.OS] as? String { self.os = os }
		if let manufacturer = representation[Fields.Manufacturer] as? String { self.manufacturer = manufacturer }
		if let isCheckedOut = representation[Fields.CheckedOut] as? Bool { self.isCheckedOut = isCheckedOut }
		if let lastCheckedOutDate = representation[Fields.LastCheckedOutDate] as? String { self.lastCheckedOutDate = NSDate(fromRFC3339String: lastCheckedOutDate) as Date }
		if let lastCheckedOutBy = representation[Fields.LastCheckedOutBy] as? String{ self.lastCheckedOutBy = lastCheckedOutBy }
	}

	//MARK: - NSCoding
	func encode(with aCoder: NSCoder) {
		
		aCoder.encode(id, forKey: Fields.ID)
		aCoder.encode(device, forKey: Fields.Device)
		aCoder.encode(os, forKey: Fields.OS)
		aCoder.encode(manufacturer, forKey: Fields.Manufacturer)
		aCoder.encode(isCheckedOut, forKey: Fields.CheckedOut)
		aCoder.encode(lastCheckedOutDate, forKey: Fields.LastCheckedOutDate)
		aCoder.encode(lastCheckedOutBy, forKey: Fields.LastCheckedOutBy)
		aCoder.encode(syncStatus.rawValue, forKey: Fields.SyncStatus)
	}
	
	init?(coder aDecoder: NSCoder) {

		super.init()
		
		id = aDecoder.decodeObject(forKey: Fields.ID) as? Int
		device = aDecoder.decodeObject(forKey: Fields.Device) as? String
		os = aDecoder.decodeObject(forKey: Fields.OS) as? String
		manufacturer = aDecoder.decodeObject(forKey: Fields.Manufacturer) as? String
		isCheckedOut = aDecoder.decodeObject(forKey: Fields.CheckedOut) as? Bool
		lastCheckedOutDate = aDecoder.decodeObject(forKey: Fields.LastCheckedOutDate) as? Date
		lastCheckedOutBy = aDecoder.decodeObject(forKey: Fields.LastCheckedOutBy) as? String
		syncStatus = SyncStatus(rawValue: aDecoder.decodeObject(forKey: Fields.SyncStatus) as! String)!
	}
}

// MARK: - CustomStringConvertible
extension Device {
	
	var dictionaryRepresentation: [String : Any] {
		
		let representation =
			[Fields.ID : "\(id)",
			Fields.Device : device as Any,
			Fields.OS : os as Any,
			Fields.Manufacturer : manufacturer as Any,
			Fields.CheckedOut : isCheckedOut as Any,
			Fields.LastCheckedOutDate : lastCheckedOutDate as Any,
			Fields.LastCheckedOutBy : lastCheckedOutBy as Any,
			Fields.SyncStatus : syncStatus,
		] as [String : Any]
		
		return representation
	}
	
	override var description: String {
		return dictionaryRepresentation.debugDescription
	}
	
	
}

// MARK: - API Keys

// The keys to the values received in the API response
struct DeviceKey {
	
	static let ID					= "id"
	static let Device				= "device"
	static let OS					= "os"
	static let Manufacturer			= "manufacturer"
	static let CheckedOut			= "isCheckedOut"
	static let LastCheckedOutDate	= "lastCheckedOutDate"
	static let LastCheckedOutBy		= "lastCheckedOutBy"
	static let SyncStatus			= "syncStatus"
}
