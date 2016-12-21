//
//  DeviceDetailViewController.swift
//  Tracker
//
//  Created by Marc Dermejian on 17/12/2016.
//  Copyright © 2016 Marc Dermejian. All rights reserved.
//

import UIKit

class DeviceDetailViewController: UIViewController {

	// MARK: - stored properties
	var device: Device!
	
	// MARK: - IBOutlets
	@IBOutlet weak var deviceLabel: UILabel!
	@IBOutlet weak var osLabel: UILabel!
	@IBOutlet weak var manufacturerLabel: UILabel!
	@IBOutlet weak var checkedOutLabel: UILabel!
	@IBOutlet weak var checkInOutButton: UIButton!
	
	
	// MARK: UIViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
		title = "Detail"
		updateUI()
    }
	
	// MARK: UI Update
	private func updateUI () {
		if let device = device {
			deviceLabel.text = device.model
			osLabel.text = device.os
			manufacturerLabel.text = device.manufacturer
			checkedOutLabel.text = device.status
			checkInOutButton.isHidden = false

			if device.isCheckedOut != nil {
				let title = device.isCheckedOut! ? "Check In" : "Check Out"
				checkInOutButton.setTitle(title, for: .normal)
			}
		}
	}

	// MARK: - IBActions
	@IBAction func checkInOut(_ sender: UIButton) {
		
		if let isCheckedOut = device.isCheckedOut{
			isCheckedOut ? checkIn() : showAlert()
		}
		
	}
	
	// MARK: - Helper funcs
	private func checkIn() {

		device.isCheckedOut = false
		
		// Update object's sync status so it is handled on the next sync cycle
		// Only set syncStatus to .updated if the deviceID is not nil
		// a nil deviceID means the object was created locally and has not been synced yet
		// In this case, do not set status to updated
		device.syncStatus = device.id != nil ? .updated : .created

		
		updateUI()
	}

	private func checkOut(usingName name: String) {

		device.isCheckedOut = true
		device.lastCheckedOutBy = name
		device.lastCheckedOutDate = Date()
		
		// Update object's sync status so it is handled on the next sync cycle
		// Only set syncStatus to .updated if the deviceID is not nil
		// a nil deviceID means the object was created locally and has not been synced yet
		// In this case, do not set status to updated
		device.syncStatus = device.id != nil ? .updated : .created
		
		
		updateUI()
	}
	
	private func showAlert () {
		let alertController = UIAlertController(title: "Last Checked out by", message: nil, preferredStyle: .alert)
		
		let checkoutAction = UIAlertAction(title: "Check Out", style: .default) { (_) in
			let nameTextField = alertController.textFields![0] as UITextField
			
			//call checkOut function
			self.checkOut(usingName: nameTextField.text!)
		}
		checkoutAction.isEnabled = false
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
		
		alertController.addTextField { (textField) in
			textField.placeholder = "Enter name"
			
			NotificationCenter.default.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange, object: textField, queue: OperationQueue.main) { (notification) in
				checkoutAction.isEnabled = textField.text != ""
			}
		}
		
		alertController.addAction(checkoutAction)
		alertController.addAction(cancelAction)
		
		present(alertController, animated: true)
	}
}
