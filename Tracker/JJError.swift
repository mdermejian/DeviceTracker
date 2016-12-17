//
//  JJError.swift
//  Tracker
//
//  Created by Marc Dermejian on 15/12/2016.
//  Copyright © 2016 Marc Dermejian. All rights reserved.
//

import Foundation

enum JJError: Error {
	case network(error: Error) // Capture any underlying Error from the URLSession API
	case dataSerialization(error: Error)
	case jsonSerialization(error: Error)
	case xmlSerialization(error: Error)
	case objectSerialization(reason: String)
}
