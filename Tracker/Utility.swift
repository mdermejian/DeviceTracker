//
//  Utility.swift
//  Tracker
//
//  Created by Marc Dermejian on 20/12/2016.
//  Copyright © 2016 Marc Dermejian. All rights reserved.
//

import Foundation
import Commons

final class Utility {
	
	// used to transform an ISO8601 date string to foundation Date object
	static var iso8601DateFormatter: DateFormatter {
		let formatter = DateFormatter.internetDateTime()!
		formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
		return formatter
	}
	
}
