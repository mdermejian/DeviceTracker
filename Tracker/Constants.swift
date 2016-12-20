//
//  Constants.swift
//  Tracker
//
//  Created by Marc Dermejian on 20/12/2016.
//  Copyright © 2016 Marc Dermejian. All rights reserved.
//

import Foundation

struct Config {
	
	static let baseURL = "http://private-1cc0f-devicecheckout.apiary-mock.com"
	static let timeout = TimeInterval(30)
	
	//MARK: Archiving Paths
	static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
	static let ArchiveURL = DocumentsDirectory.appendingPathComponent("devices")
	static let DeletedObjectsURL = DocumentsDirectory.appendingPathComponent("deleted")

}
