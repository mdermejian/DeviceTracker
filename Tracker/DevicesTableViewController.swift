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
	
	// MARK: Computed constants

	private let deviceManager: DeviceManager = {
		return DeviceManager()
	}()
	
	// MARK: Constants
	
	//Keep constants' scope as small as possible
	private struct Constants {
		static let CellReuseId = "DeviceCell"
		
		static let DeviceDetailViewSceneIdentifier = "DeviceDetail"
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
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tableView.isUserInteractionEnabled = true
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
			
//			self.devices = _devices
//			OperationQueue.main.addOperation {
//				self.tableView.reloadData()
//			}

			
			var indexPaths: [IndexPath] = []
			for device in _devices {
				let row = self.devices.count
				indexPaths += [IndexPath(row: row, section:0)]
				self.devices += [device]
			}
			
			OperationQueue.main.addOperation {
				self.tableView.beginUpdates()
				self.tableView.insertRows(at: indexPaths, with: .fade)
				self.tableView.endUpdates()
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
			deleteElement(atIndexPath: indexPath)
		}
	}
	
	private func deleteElement(atIndexPath indexPath: IndexPath) {
		
		guard let deviceID = devices[indexPath.row].id else { return }
		
		deviceManager.delete(device: "\(deviceID)") { [weak self] success in
			// Delete the row from the data source
			self?.devices.remove(at: indexPath.row)
			self?.tableView.deleteRows(at: [indexPath], with: .fade)
		}
	}
	
	// MARK: - UITableViewDelegate
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		tableView.isUserInteractionEnabled = false
		guard let destinationViewController = storyboard?.instantiateViewController(withIdentifier: Constants.DeviceDetailViewSceneIdentifier) as? DeviceDetailViewController
			else {
				return
		}
		
		destinationViewController.device = devices[indexPath.row]
		destinationViewController.deviceManager = deviceManager
		navigationController?.pushViewController(destinationViewController, animated: true)
		
	}
	
	// MARK: - Navigation
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		//Injecting the deviceManager object when presenting the CreateDeviceViewController
		if segue.identifier == Constants.CreateDeviceSegueIdentifier {
			if let navController = segue.destination as? UINavigationController,
				let destinationVC = navController.topViewController as? CreateDeviceViewController {
				destinationVC.deviceManager = deviceManager
			}
		}
	}
	
	@IBAction func unwindToDevicesView(segue: UIStoryboardSegue) {
	}


}

