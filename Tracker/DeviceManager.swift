//
//  DeviceManager.swift
//  Tracker
//
//  Created by Marc Dermejian on 15/12/2016.
//  Copyright © 2016 Marc Dermejian. All rights reserved.
//

import Alamofire

/*
This is the network controller for Device related API calls: it talks to the backend and then pushes data into your cache, into your persistence engine. (not implemented yet here)
*/
class DeviceManager {
	
	private (set) var deletedDevices: [Device] {
		get {
			return storageManager.loadDeletedDevices()
		}
		set {
			storageManager.save(deletedDevices: newValue)
		}
	}
	
	func add(deletedDevice device: Device) {
		deletedDevices += [device]
	}
	
	
	let storageManager = StorageManager()

	//MARK: Fetch devices
	func getDevices(completion: @escaping (_ success: Bool, _ devices: [Device]?) -> Void) {
		
		let devices = storageManager.loadDevices()
		if devices.count > 0 {
			OperationQueue.main.addOperation {
				completion(true, devices)
			}
			return
		}
		
		let request = DeviceRouter(endpoint: .GetAllDevices)
		Alamofire.request(request)
			
			//Validates that the response has a status code in the default acceptable range of 200…299, and that the content type matches any specified in the Accept HTTP header field.
			//If validation fails, subsequent calls to response handlers will have an associated error.
			.validate()
			
			//Use Generic Response Object Serialization to map the response into a GetAllDevicesResponse object
			.responseCollection { (response: DataResponse<[Device]>) in

				if response.result.isSuccess, let devices = response.result.value {
					self.storageManager.save(devices: devices)
				}
				
				OperationQueue.main.addOperation {
					completion(response.result.isSuccess, response.result.value)
				}
			}
	}
	
	// MARK: Create device
	func create(device deviceParameters: [String: AnyObject], completion: @escaping (_ success: Bool, _ device: Device?) -> Void) {
		
		let request = DeviceRouter(endpoint: .CreateDevice(parameters: deviceParameters))
		Alamofire.request(request)
			
			//Validates that the response has a status code in the default acceptable range of 200…299, and that the content type matches any specified in the Accept HTTP header field.
			//If validation fails, subsequent calls to response handlers will have an associated error.
			.validate()
			
			//Use Generic Response Object Serialization to map the response into a Device object
			.responseObject { (response: DataResponse<Device>) in
				OperationQueue.main.addOperation {
					completion(response.result.isSuccess, response.result.value)
				}
			}
	}
	
	// MARK: Delete device
	func delete(device deviceID: String, completion: @escaping (_ success: Bool) -> Void) {
		
		let request = DeviceRouter(endpoint: .DestroyDevice(id: deviceID))
		Alamofire.request(request)
			
			//Validates that the response has a status code in the default acceptable range of 200…299, and that the content type matches any specified in the Accept HTTP header field.
			//If validation fails, subsequent calls to response handlers will have an associated error.
			.validate()

			.responseString { response in
				OperationQueue.main.addOperation {
					completion(response.result.isSuccess)
				}
			}
	}

	
	// MARK: Check device in/out
	func update(device: Device, completion: @escaping (_ success: Bool) -> Void) {
		
		if let isCheckedOut = device.isCheckedOut {
			isCheckedOut
				? checkOut(device: device.model!, person: device.lastCheckedOutBy!, date: device.lastCheckedOutDate!, completion: completion)
				: checkIn(device: device.model!, completion: completion)
		}
	}

	private func checkIn(device deviceID: String, completion: @escaping (_ success: Bool) -> Void) {
		
		let params = [DeviceKey.CheckedOut : false.description]
		self.update(device: deviceID, params: params as [String : AnyObject], completion: completion)
	}
	
	private func checkOut(device deviceID: String, person: String, date: Date, completion: @escaping (_ success: Bool) -> Void) {
		
		let date = Utility.iso8601DateFormatter.string(from: date)
		let params = [DeviceKey.LastCheckedOutBy : person as AnyObject,
		              DeviceKey.LastCheckedOutDate : date as AnyObject,
		              DeviceKey.CheckedOut : true.description as AnyObject
		              ]
		
		self.update(device: deviceID, params: params, completion: completion)

	}
	
	private func update(device deviceID: String, params: [String : AnyObject], completion: @escaping (_ success: Bool) -> Void) {
		
		let request = DeviceRouter(endpoint: .UpdateDevice(id: deviceID, parameters: params))
		
		Alamofire.request(request)
			
			//Validates that the response has a status code in the default acceptable range of 200…299, and that the content type matches any specified in the Accept HTTP header field.
			//If validation fails, subsequent calls to response handlers will have an associated error.
			.validate()
			
			.responseString { response in
				OperationQueue.main.addOperation {
					completion(response.result.isSuccess)
				}
		}
	}
}
