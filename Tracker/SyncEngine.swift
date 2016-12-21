//
//  SyncEngine.swift
//  Tracker
//
//  Created by Marc Dermejian on 18/12/2016.
//  Copyright © 2016 Marc Dermejian. All rights reserved.
//

import Alamofire

class SyncEngine {
	
	//Singleton shared instance
	static let shared = SyncEngine()
	
	//hide the default init
	private init() {}
	
	private let storageManager = StorageManager()
	private let deviceManager = DeviceManager()
	
	// MARK: - network activity indicator management
	static var networkOperations: Int = 0 {
		didSet {
			UIApplication.shared.isNetworkActivityIndicatorVisible = networkOperations > 0
		}
	}
	
	// MARK: - Sync
	func sync () {
		
		// ongoing sync, avoid re-triggering
		guard SyncEngine.networkOperations == 0 else {
			return
		}
		createLocalObjects()
		deleteLocalObjects()
		updateLocalObjects()
	}

	private func createLocalObjects() {
		
		var devices = storageManager.loadDevices()
		for (index, device) in devices.enumerated() where device.syncStatus == .created {
			
			print("creating \(device) \n")
			
			let params = [DeviceKey.Device : device.model,
						  DeviceKey.OS : device.os,
						  DeviceKey.Manufacturer : device.manufacturer
			]

			SyncEngine.networkOperations += 1
			deviceManager.create(device: params as [String : AnyObject]) { success, _device in
				if success {
					// the backend will set the ID
					device.id = _device?.id
					
					// reset the sync status to .none
					device.syncStatus = .none
					
					//update data store
					devices[index] = device
					self.storageManager.save(devices: devices)
					
					//if the device has been edited after being created, we need to issue an update API call
					if device.lastCheckedOutDate != nil {
						// set the sync flag to updated
						device.syncStatus = .updated
						
						//update the data store
						devices[index] = device
						self.storageManager.save(devices: devices)
						
						//update the backend
						self.updateLocalObjects()
					}
				}
				SyncEngine.networkOperations -= 1
			}
		}
	}

	private func deleteLocalObjects() {
		
		var deletedDevices = storageManager.loadDeletedDevices()
		for device in deletedDevices {
			
			print("deleting \(device) \n")
			
			//locally created devices have id == nil
			//If created locally and never synced, id would remain nil
			//only send sync request if the id is not nil
			guard device.id != nil else {
				//update the data store
				deletedDevices.remove(at: deletedDevices.index(of: device)!)
				self.storageManager.save(deletedDevices: deletedDevices)
				continue
			}

			
			SyncEngine.networkOperations += 1
			deviceManager.delete(device: "\(device.id!)") { success in
				if success {
					
					// look for the item again, index is useless here because items will not necessarily be removed in order
					let deviceIndex = deletedDevices.index(of: device)
					
					//update the data store
					deletedDevices.remove(at: deviceIndex!)
					self.storageManager.save(deletedDevices: deletedDevices)
				}
				SyncEngine.networkOperations -= 1
			}
		}
	}
	
	private func updateLocalObjects() {
		
		var devices = storageManager.loadDevices()
		for (index, device) in devices.enumerated() where device.syncStatus == .updated {
			
			print("updating \(device) \n")
			
			
			let completionHandler: (Bool) -> (Void) = { (success) in
				if success {
					
					// reset the sync status to .none
					device.syncStatus = .none
					
					//update the data store
					devices[index] = device
					self.storageManager.save(devices: devices)
				}
				SyncEngine.networkOperations -= 1
			}
			
			SyncEngine.networkOperations += 1
			deviceManager.update(device: device, completion: completionHandler)
			
		}
	}
}
