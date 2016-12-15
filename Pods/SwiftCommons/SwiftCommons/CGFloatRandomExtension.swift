//
//  CGFloatRandomExtension.swift
//  QuickBloxTest
//
//  Created by Marc Dermejian on 15/03/2016.
//  Copyright © 2016 Fexco Software Group. All rights reserved.
//

import UIKit

public extension CGFloat{
	public static func random(_ max: Int) -> CGFloat {
		return CGFloat(arc4random() % UInt32(max))
	}
}
