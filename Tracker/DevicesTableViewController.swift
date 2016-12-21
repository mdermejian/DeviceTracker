//
//  DevicesTableViewController.swift
//  Tracker
//
//  Created by Marc Dermejian on 17/12/2016.
//  Copyright © 2016 Marc Dermejian. All rights reserved.
//

import UIKit

class DevicesTableViewController: UITableViewController {
	
	// MARK: Stored properties
	
	private var isLoading = false {
		didSet {
			loadingFooterView?.isHidden = !isLoading
			UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
		}
	}
	
	//List of devices for the table view
	private var devices: [Device] = []
	
	private let deviceManager = DeviceManager()
	
	
	// MARK: Constants
	//Keep constants' scope as small as possible
	private struct Constants {
		static let CellReuseId = "DeviceCell"
		
		static let DeviceDetailViewSegueIdentifier = "ShowDeviceDetail"
		static let CreateDeviceSegueIdentifier = "CreateDevice"
		
		static let Devices_Title = NSLocalizedString("Devices_Title", comment: "The title of the Devices table view")
		static let Network_Error_Message_Title = NSLocalizedString("Network_Error_Message_Title", comment: "The title of the network error message")
		static let Network_Error_Message_Body = NSLocalizedString("Network_Error_Message_Body", comment: "The body of the network error message")
		static let OK_Action = NSLocalizedString("OK_Action", comment: "Okay button title")
	}
	
	// MARK: IBOutlets
	
	@IBOutlet weak var loadingFooterView: UIView!
	
	// MARK: - View controller lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = Constants.Devices_Title
		loadDevices()
	}
	
	// MARK: Networking
	
	private func loadDevices() {
		
		guard isLoading == false else { return }
		
		isLoading = true
		
		deviceManager.getDevices { (success, _devices) in
			
			self.isLoading = false
			
			guard success == true, let _devices = _devices else {
				
				//present alert controller with error message
				let alertController = UIAlertController(title: Constants.Network_Error_Message_Title, message: Constants.Network_Error_Message_Body, preferredStyle: .alert)
				let okAction = UIAlertAction(title: Constants.OK_Action, style: .default)
				alertController.addAction(okAction)
				self.present(alertController, animated: true)
				
				return
			}
			
			self.devices = _devices
			OperationQueue.main.addOperation {
				self.tableView.reloadData()
			}
		}
	}
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return devices.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellReuseId, for: indexPath) as! DeviceCell
		cell.device = devices[indexPath.row]
		return cell
	}
	
	// MARK: Inserting or Deleting Table Rows

	// Override to support conditional editing of the table view.
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		// Return false if you do not want the specified item to be editable.
		return true
	}
	
	// Override to support editing the table view.
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			deleteDevice(atIndexPath: indexPath)
		}
	}
	
	private func deleteDevice(atIndexPath indexPath: IndexPath) {
		
		let device = devices[indexPath.row]
		
		// Delete the row from the data source
		devices.remove(at: indexPath.row)
		tableView.deleteRows(at: [indexPath], with: .fade)

		//update our storage
		deviceManager.storageManager.save(devices: devices)
		deviceManager.add(deletedDevice: device)
		
		//Attempt to sync
		SyncEngine.shared.sync()

	}
	
	// MARK: - Navigation
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		if segue.identifier == Constants.DeviceDetailViewSegueIdentifier {
			let deviceDetailViewController = segue.destination as! DeviceDetailViewController
			
			// Get the cell that generated this segue.
			if let selectedDeviceCell = sender as? DeviceCell {
				let indexPath = tableView.indexPath(for: selectedDeviceCell)!
				let selectedDevice = devices[indexPath.row]
				deviceDetailViewController.device = selectedDevice
			}
		}
	}

	@IBAction func unwindToDevicesView(sender: UIStoryboardSegue) {
		
		// Device edited
		if let sourceViewController = sender.source as? DeviceDetailViewController,
			let device = sourceViewController.device,
			let selectedIndexPath = tableView.indexPathForSelectedRow {
			
			// Update an existing device.
			devices[selectedIndexPath.row] = device
			tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
			deviceManager.storageManager.save(devices: devices)
			
			//Attempt to sync
			//SyncEngine.shared.updateLocalObjects()
			SyncEngine.shared.sync()

		}
		
		// New device created
		if let sourceViewController = sender.source as? CreateDeviceViewController,
			let device = sourceViewController.device {
			
			// Add a new device.
			let newIndexPath = IndexPath(row: devices.count, section: 0)
			devices += [device]
			
			tableView.insertRows(at: [newIndexPath], with: .bottom)
			
			deviceManager.storageManager.save(devices: devices)

			//Attempt to sync
			SyncEngine.shared.sync()

		}
	}

}

