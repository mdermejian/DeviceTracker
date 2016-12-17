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
	
	//Singleton shared instance
//	static let sharedManager = DeviceManager()
	
	//hide the default init
//	private init() {}
	
	//MARK: methods
	
	func getDevices(completion: @escaping (_ success: Bool, _ devices: [Device]?) -> Void) {
		
		let request = DeviceRouter(endpoint: .GetAllDevices)
		Alamofire.request(request)
			
			//Validates that the response has a status code in the default acceptable range of 200…299, and that the content type matches any specified in the Accept HTTP header field.
			//If validation fails, subsequent calls to response handlers will have an associated error.
			.validate()
			
			//Use Generic Response Object Serialization to map the response into a GetAllDevicesResponse object
			.responseCollection(completionHandler: { (response: DataResponse<[Device]>) in
				OperationQueue.main.addOperation {
					completion(response.result.isSuccess, response.result.value)
				}
			})
	}
	
	func create(device deviceParameters: [String: AnyObject], completion: @escaping (_ success: Bool, _ device: Device?) -> Void) {
		
		let request = DeviceRouter(endpoint: .CreateDevice(parameters: deviceParameters))
		Alamofire.request(request)
			
			//Validates that the response has a status code in the default acceptable range of 200…299, and that the content type matches any specified in the Accept HTTP header field.
			//If validation fails, subsequent calls to response handlers will have an associated error.
			.validate()
			
			
			.responseObject { (response: DataResponse<Device>) in
				OperationQueue.main.addOperation {
					completion(response.result.isSuccess, response.result.value)
				}
			}
	}
	
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

			//Use Generic Response Object Serialization to map the response into a GetAllDevicesResponse object
//			.responseCollection{ (response: DataResponse<[Device]>) in
//				debugPrint(response)
//				completion(response.result.isSuccess)
				//				completion(response.result.isSuccess,
				//				           response.result.value?.count,
				//				           response.result.value?.hasMore,
				//				           response.result.value?.devices)
				
//			}
	}

	func checkIn(device deviceID: String, completion: @escaping (_ success: Bool) -> Void) {
		
		let params = [DeviceKey.CheckedOut.rawValue : false.description]
		self.update(device: deviceID, params: params as [String : AnyObject], completion: completion)
	}
	
	func checkOut(device deviceID: String, person: String, completion: @escaping (_ success: Bool) -> Void) {
		
		let date = DateFormatter.shared().string(from: Date())
		
		let params = [DeviceKey.LastCheckedOutBy.rawValue : person as AnyObject,
		              DeviceKey.LastCheckedOutDate.rawValue : date as AnyObject,
		              DeviceKey.CheckedOut.rawValue : true.description as AnyObject
		              ]
		
		self.update(device: deviceID, params: params, completion: completion)


	}
	
	private func update(device deviceID: String, params: [String : AnyObject], completion: @escaping (_ success: Bool) -> Void) {
		
		let request = DeviceRouter(endpoint: .UpdateDevice(id: deviceID, parameters: params))
		
		Alamofire.request(request)
			
			
			.validate()
			
			
			.responseString { response in
				
				OperationQueue.main.addOperation {
					completion(response.result.isSuccess)
				}
				
				
		}

	}

}
