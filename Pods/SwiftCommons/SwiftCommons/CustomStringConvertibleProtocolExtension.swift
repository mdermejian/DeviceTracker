//
//  CustomStringConvertibleProtocolExtension.swift
//  Intranet
//
//  Created by Marc Dermejian on 07/04/2016.
//  Copyright © 2016 Fexco Software Group. All rights reserved.
//

import Foundation

public extension CustomStringConvertible {
	
	var description : String {
		var description = "!***** \(type(of: self)) *****!\n"
		let selfMirror = Mirror(reflecting: self)
		for child in selfMirror.children {
			if let propertyName = child.label {
				description += "\(propertyName) : \(child.value) \n"
			}
		}
		return description
	}
}
