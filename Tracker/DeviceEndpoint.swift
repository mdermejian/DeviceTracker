//
//  DeviceEndpoint.swift
//  Tracker
//
//  Created by Marc Dermejian on 15/12/2016.
//  Copyright © 2016 Marc Dermejian. All rights reserved.
//

import Alamofire

/*
enum listing the Device end points
*/
enum DeviceEndpoint {
	
	case GetAllDevices
	case CreateDevice(parameters: Parameters)
	case UpdateDevice(id: Int, parameters: Parameters)
	case DestroyDevice(id: Int)
}
