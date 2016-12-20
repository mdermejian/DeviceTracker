//
//  AppDelegate.swift
//  Tracker
//
//  Created by Marc Dermejian on 15/12/2016.
//  Copyright © 2016 Marc Dermejian. All rights reserved.
//

import UIKit
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	
	let reachabilityManager: NetworkReachabilityManager = {
		let rm = NetworkReachabilityManager(host: Config.baseURL)
		rm?.startListening()
		rm?.listener = { status in
			switch status {
			case .reachable: SyncEngine.shared.sync()
			default: break
			}
		}
		return rm!
	}()
	
}
