//
//  DeviceStatus.swift
//  Tracker
//
//  Created by Marc Dermejian on 15/12/2016.
//  Copyright © 2016 Marc Dermejian. All rights reserved.
//

import Foundation

enum DeviceStatus {
	case available
	case checkedOut(date: Date, by: String)
}
