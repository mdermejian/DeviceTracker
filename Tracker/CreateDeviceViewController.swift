//
//  CreateDeviceViewController.swift
//  Tracker
//
//  Created by Marc Dermejian on 17/12/2016.
//  Copyright © 2016 Marc Dermejian. All rights reserved.
//

import UIKit

class CreateDeviceViewController: UIViewController, UITextFieldDelegate {

	
	// MARK: - stored properties
	var device: Device?
	
	// MARK: - computed properties
	var isSaveEnabled: Bool {
		return deviceTextField.text != ""
			&& osTextField.text != ""
			&& manufacturerTextField.text != ""
	}
	
	var textFieldsNotEmpty: Bool {
		return deviceTextField.text != ""
			|| osTextField.text != ""
			|| manufacturerTextField.text != ""
	}
	
	private var deviceParams: [String : AnyObject] {
		let params = [DeviceKey.Device : deviceTextField.text,
		        DeviceKey.OS : osTextField.text,
		        DeviceKey.Manufacturer : manufacturerTextField.text
		]
		
		return params as [String : AnyObject]
	}
	
	private func deviceFromUserInput () -> Device {
		let device = Device(device: deviceTextField.text!,
		              os: osTextField.text!,
		              manufacturer: manufacturerTextField.text!)
		
		// Update object's sync status so it is handled on the next sync cycle
		device.syncStatus = .created
		return device
	}
	
	// MARK: - IBOutlets
	@IBOutlet weak var deviceTextField: UITextField! {
		didSet {
			NotificationCenter.default.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange, object: deviceTextField, queue: OperationQueue.main) { (notification) in
				self.updateSaveButtonState ()
			}
		}
	}
	
	@IBOutlet weak var osTextField: UITextField! {
		didSet {
			NotificationCenter.default.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange, object: osTextField, queue: OperationQueue.main) { (notification) in
				self.updateSaveButtonState ()
			}
		}
	}
	
	@IBOutlet weak var manufacturerTextField: UITextField! {
		didSet {
			NotificationCenter.default.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange, object: manufacturerTextField, queue: OperationQueue.main) { (notification) in
				self.updateSaveButtonState ()
			}
		}
	}
	
	@IBOutlet weak var saveButton: UIBarButtonItem! {
		didSet {
			saveButton.isEnabled = false
		}
	}
	
	// MARK: - IBActions
	@IBAction func cancelTapped(_ sender: UIBarButtonItem) {
		if textFieldsNotEmpty {
			presentActionSheet()
		}else {
			dismiss()
		}
	}
	
	@IBAction func saveTapped(_ sender: UIBarButtonItem) {
		dismissKeyboard()
		self.device = deviceFromUserInput()
		self.performSegue(withIdentifier: "unwindToDevicesTableView", sender: self)
	}
	
	@IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
		dismissKeyboard()
	}

	// MARK: UIViewController lifecycle
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		deviceTextField.becomeFirstResponder()
	}
	
	// MARK: - Helper funcs
	private func updateSaveButtonState () {
		saveButton.isEnabled = isSaveEnabled
	}

	private func dismiss () {
		presentingViewController?.dismiss(animated: true)
	}

	private func dismissKeyboard () {
		deviceTextField.resignFirstResponder()
		osTextField.resignFirstResponder()
		manufacturerTextField.resignFirstResponder()
	}

	private func presentActionSheet () {
		let alertController = UIAlertController(title: nil, message: "You have entered some information. By continuing you will lose all entered data", preferredStyle: .actionSheet)
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
		alertController.addAction(cancelAction)
		
		let destroyAction = UIAlertAction(title: "Dismiss", style: .destructive) { (action) in
			self.dismiss()
		}
		alertController.addAction(destroyAction)
		
		self.present(alertController, animated: true)
	}
	
	// MARK: - UITextField delegate
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		
		switch textField {
		case deviceTextField: osTextField.becomeFirstResponder()
		case osTextField: manufacturerTextField.becomeFirstResponder()
		case manufacturerTextField: manufacturerTextField.resignFirstResponder()
		default: break
		}
		
		return true
	}
}
