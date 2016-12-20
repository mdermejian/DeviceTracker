//
//  StorageManager.swift
//  Tracker
//
//  Created by Marc Dermejian on 18/12/2016.
//  Copyright © 2016 Marc Dermejian. All rights reserved.
//

import Foundation

class StorageManager {
	
	@discardableResult
	func save(devices: [Device]) -> Bool {
		let saved = NSKeyedArchiver.archiveRootObject(devices, toFile: Config.ArchiveURL.path)
		return saved
	}
	
	func loadDevices() -> [Device] {
		guard let devices = NSKeyedUnarchiver.unarchiveObject(withFile: Config.ArchiveURL.path) as? [Device]
			else { return [] }
		return devices
	}

	@discardableResult
	func save(deletedDevices devices: [Device]) -> Bool {
		let saved = NSKeyedArchiver.archiveRootObject(devices, toFile: Config.DeletedObjectsURL.path)
		return saved
	}
	
	func loadDeletedDevices() -> [Device] {
		guard let deletedDevices = NSKeyedUnarchiver.unarchiveObject(withFile: Config.DeletedObjectsURL.path) as? [Device]
			else { return [] }
		return deletedDevices
	}

}
