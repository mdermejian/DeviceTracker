//
//  ResponseCollectionSerializable.swift
//  Tracker
//
//  Created by Marc Dermejian on 15/12/2016.
//  Copyright © 2016 Marc Dermejian. All rights reserved.
//

import Alamofire

/*
Generic "collection of objects" serialization
Uses the same approach as ResponseObjectSerializable to handle endpoints that return a representation of a collection of objects
Refer to https://github.com/Alamofire/Alamofire#generic-response-object-serialization for a detailed explanation

*/
protocol ResponseCollectionSerializable {
	static func collection(from response: HTTPURLResponse, withRepresentation representation: Any) -> [Self]
}

extension ResponseCollectionSerializable where Self: ResponseObjectSerializable {
	static func collection(from response: HTTPURLResponse, withRepresentation representation: Any) -> [Self] {
		var collection: [Self] = []
		
		if let representation = representation as? [[String: Any]] {
			for itemRepresentation in representation {
				if let item = Self(response: response, representation: itemRepresentation) {
					collection.append(item)
				}
			}
		}
		
		return collection
	}
}

/*
Alamofire.DataRequest extension allowing a custom object serialization
*/
extension DataRequest {
	@discardableResult
	func responseCollection<T: ResponseCollectionSerializable>(
		queue: DispatchQueue? = nil,
		completionHandler: @escaping (DataResponse<[T]>) -> Void) -> Self
	{
		let responseSerializer = DataResponseSerializer<[T]> { request, response, data, error in
			guard error == nil else { return .failure(JJError.network(error: error!)) }
			
			let jsonSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
			let result = jsonSerializer.serializeResponse(request, response, data, nil)
			
			guard case let .success(jsonObject) = result else {
				return .failure(JJError.jsonSerialization(error: result.error!))
			}
			
			guard let response = response else {
				let reason = "Response collection could not be serialized due to nil response."
				return .failure(JJError.objectSerialization(reason: reason))
			}
			
			return .success(T.collection(from: response, withRepresentation: jsonObject))
		}
		
		return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
	}
}
