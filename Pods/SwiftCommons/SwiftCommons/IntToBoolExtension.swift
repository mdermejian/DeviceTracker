//
//  IntToBoolExtension.swift
//  SwiftCommons
//
//  Created by Marc Dermejian on 12/08/2016.
//  Copyright © 2016 Marc Dermejian. All rights reserved.
//

import Foundation

public extension Int {
 
	public func toBool () -> Bool? {
		switch self {
		case 0:
			return false
		case 1:
			return true
		default:
			return nil
		}
	}
}
