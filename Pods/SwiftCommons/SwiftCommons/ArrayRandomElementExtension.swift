//
//  ArrayRandomExtension.swift
//  QuickBloxTest
//
//  Created by Marc Dermejian on 23/03/2016.
//  Copyright © 2016 Fexco Software Group. All rights reserved.
//

import Foundation

public extension Array {
	public func randomElement() -> Iterator.Element {
		return self[Int(arc4random_uniform(UInt32(self.count)))]
	}
}
