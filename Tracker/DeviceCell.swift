//
//  DeviceCell.swift
//  ZendeskTest
//
//  Created by Marc Dermejian on 17/12/2016.
//  Copyright © 2016 Marc Dermejian. All rights reserved.
//

import UIKit

class DeviceCell: UITableViewCell {

	//MARK: API
	var device: Device? {
		didSet {
			updateUI()
		}
	}
	
	// MARK: IBOutlets
	@IBOutlet weak var mainLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	
	//MARK: UI update
	private func updateUI () {
		
		guard let device = device else { return }
		
		mainLabel.text = device.deviceInfo
		descriptionLabel.text = device.status

	}
}
