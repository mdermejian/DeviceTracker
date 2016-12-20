//
//  DeviceRouter.swift
//  Tracker
//
//  Created by Marc Dermejian on 15/12/2016.
//  Copyright © 2016 Marc Dermejian. All rights reserved.
//

import Alamofire

//Encapsulates the details of a URLRequest for each DeviceEndpoint API case
class DeviceRouter: URLRequestConvertible, APIConfigurator {
	
	var endpoint: DeviceEndpoint
	init(endpoint: DeviceEndpoint) {
		self.endpoint = endpoint
	}
	
	
	//MARK: - APIConfigurator implementation - URL Request properties
	var baseURL: URL {
		return URL(string: Config.baseURL)!
	}
	
	var method: HTTPMethod {
		switch self.endpoint {
		case .GetAllDevices: return .get
		case .CreateDevice: return .post
		case .UpdateDevice: return .post
		case .DestroyDevice: return .delete
		}
	}
	
	var encoding: Alamofire.ParameterEncoding {
		switch self.endpoint {
		case .GetAllDevices: return URLEncoding.default
		case .CreateDevice: return JSONEncoding.default
		case .UpdateDevice: return JSONEncoding.default
		case .DestroyDevice: return URLEncoding.default
		}
	}
	
	//relative path to be appended to the base url
	var relativePath: String {
		switch self.endpoint {
		case .GetAllDevices, .CreateDevice: return ("/devices")
		case let .UpdateDevice(id, _),
			let .DestroyDevice(id): return ("/devices/\(id)")
		}
	}
	
	var parameters: [String: AnyObject]? {
		
		switch self.endpoint {
		case let .CreateDevice(_params),
			let .UpdateDevice(_, _params):
			return _params
		default:return nil
		}
	}
	
	var timeoutInterval: TimeInterval {
		return Config.timeout
	}
	
	var defaultHeaders: [String: String] {
		
		var headers: [String:String] = [:]
		
		/*
		The API is a JSON API. (????)
		You must supply a Content-Type: application/json header in PUT and POST requests.
		You must set an Accept: application/json header on all requests.
		*/
		headers["Accept"] = "application/json"
		
		return headers
	}
	
	// MARK: - URLRequestConvertible
	func asURLRequest() throws -> URLRequest {
		
		//build the URLRequest from all the individual components
		var urlRequest = try URLRequest(url: baseURL.appendingPathComponent(relativePath),
		                                method: method,
		                                headers: defaultHeaders)
		urlRequest.timeoutInterval = timeoutInterval
		
		return try encoding.encode(urlRequest, with: parameters)
		
	}
}
