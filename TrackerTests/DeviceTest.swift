//
//  DeviceTest.swift
//  Tracker
//
//  Created by Marc Dermejian on 21/12/2016.
//  Copyright © 2016 Marc Dermejian. All rights reserved.
//

import XCTest
@testable import Tracker

class DeviceTest: XCTestCase {
	
	var blankDevice: [String: AnyObject] = [:]
	let dummyResponse = HTTPURLResponse()

	override func tearDown() {
		super.tearDown()
		blankDevice = [:]
	}
	
	func testConstructorReturnsNonNil() {
		
		let device = Device(response: dummyResponse, representation: blankDevice)
		XCTAssertNotNil(device, "device should not be nil")
		
	}
	
	func testDefaults() {
		
		guard let device = Device(response: dummyResponse, representation: blankDevice) else {
			XCTFail("guard statement failed")
			return
		}
		
		XCTAssert(device.syncStatus == .none, "device.syncStatus should be none")
	}
	
	func testPropertiesAreNil() {
		
		let device = Device(response: dummyResponse, representation: blankDevice)
		
		XCTAssertNil(device!.id, "uninitialized optional property should be nil")
		XCTAssertNil(device!.model, "uninitialized optional property should be nil")
		XCTAssertNil(device!.os, "uninitialized optional property should be nil")
		XCTAssertNil(device!.manufacturer, "uninitialized optional property should be nil")
		XCTAssertNil(device!.isCheckedOut, "uninitialized optional property should be nil")
		XCTAssertNil(device!.lastCheckedOutDate, "uninitialized optional property should be nil")
		XCTAssertNil(device!.lastCheckedOutBy, "uninitialized optional property should be nil")
	}
	
	func testInvalidRepresentation() {
		
		let invalidRepresentation: [Int: String] = [1:"xxx"]
		let device = Device(response: dummyResponse, representation: invalidRepresentation)
		XCTAssertNil(device, "device should be nil")
	}
	
	func testValidRepresentation() {
		
		/*
		var id: Int?
		var model: String?
		var os: String?
		var manufacturer: String?
		var isCheckedOut: Bool?
		var lastCheckedOutDate: Date?
		var lastCheckedOutBy: String?
		
		var syncStatus: SyncStatus = .none
		*/
		
		let validDeviceRepresentation =
			[
				"id": 418,
				"device":"iPhone 44",
				"os":"iOS 18.3",
				"manufacturer":"Applez",
				"isCheckedOut":true,
				"lastCheckedOutDate":"2016-03-26T13:53:00-05:00",
				"lastCheckedOutBy":"George Washington"
				] as [String : Any]
		
		let device = Device(response: dummyResponse, representation: validDeviceRepresentation)
		XCTAssertNotNil(device, "device should not be nil")
		
		XCTAssertTrue(device!.id == 418)
		XCTAssertTrue(device!.model == "iPhone 44")
		XCTAssertTrue(device!.os == "iOS 18.3")
		XCTAssertTrue(device!.manufacturer == "Applez")
		XCTAssertTrue(device!.isCheckedOut == true)
		XCTAssertTrue(device!.lastCheckedOutBy == "George Washington")
		
		
		let lastCheckedOutDateComponents = DateComponents(calendar: Calendar(identifier: .gregorian), timeZone: TimeZone(abbreviation: "UTC") , year: 2016, month: 3, day: 26, hour: 18, minute: 53, second: 00)
		XCTAssertTrue(device!.lastCheckedOutDate!.compare(lastCheckedOutDateComponents.date!) == .orderedSame)

	}
	
}
