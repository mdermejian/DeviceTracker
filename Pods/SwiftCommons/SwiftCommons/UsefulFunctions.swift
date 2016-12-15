//
//  UsefulFunctions.swift
//  QuickBloxTest
//
//  Created by Marc Dermejian on 30/03/2016.
//  Copyright © 2016 Fexco Software Group. All rights reserved.
//

import UIKit


public func delay(seconds: Double, completion: @escaping ()->()) {
	
	let popTime = DispatchTime.now() + seconds
	
	DispatchQueue.main.asyncAfter(deadline: popTime) { 
		completion()
	}
}
