//
//  JSONAble.swift
//  SwiftCommons
//
//  Created by Marc Dermejian on 20/04/2016.
//  Copyright © 2016 Marc Dermejian. All rights reserved.
//

import Foundation

public protocol JSONAble {
	func toDict() -> [String:Any]
}

public extension JSONAble {
	func toDict() -> [String:Any] {
		var dict = [String:Any]()
		let otherSelf = Mirror(reflecting: self)
		for child in otherSelf.children {
			if let key = child.label {
				dict[key] = child.value
			}
		}
		return dict
	}
}
