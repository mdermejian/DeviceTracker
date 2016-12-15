//
//  ResponseObjectSerializable.swift
//  Tracker
//
//  Created by Marc Dermejian on 15/12/2016.
//  Copyright © 2016 Marc Dermejian. All rights reserved.
//

import Alamofire

/*
Generic Response Object Serialization
Generics can be used to provide automatic, type-safe response object serialization.
Protocol provides built-in response serialization for custom objects that adopt this protocol
Refer to https://github.com/Alamofire/Alamofire#generic-response-object-serialization for a detailed explanation
*/
protocol ResponseObjectSerializable {
	init?(response: HTTPURLResponse, representation: Any)
}



/*
Alamofire.DataRequest extension allowing a custom object serialization
*/
extension DataRequest {
	
	@discardableResult
	func responseObject<T: ResponseObjectSerializable>(
		queue: DispatchQueue? = nil,
		completionHandler: @escaping (DataResponse<T>) -> Void)
		-> Self
	{
		let responseSerializer = DataResponseSerializer<T> { request, response, data, error in
			guard error == nil else { return .failure(JJError.network(error: error!)) }
			
			let jsonResponseSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
			let result = jsonResponseSerializer.serializeResponse(request, response, data, nil)
			
			guard case let .success(jsonObject) = result
				else {
					return .failure(JJError.jsonSerialization(error: result.error!))
			}
			
			guard let response = response, let responseObject = T(response: response, representation: jsonObject) else {
				return .failure(JJError.objectSerialization(reason: "JSON could not be serialized: \(jsonObject)"))
			}
			
			return .success(responseObject)
		}
		
		return response(queue: queue, responseSerializer: responseSerializer, completionHandler: completionHandler)
	}
}
