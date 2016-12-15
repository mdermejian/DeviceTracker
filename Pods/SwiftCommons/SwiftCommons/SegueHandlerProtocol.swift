//
//  SegueHandlerProtocol.swift
//  SwiftCommons
//
//  Created by Marc Dermejian on 18/11/2016.
//  Copyright © 2016 Marc Dermejian. All rights reserved.
//

import Foundation

public protocol SegueHandler {
	
	associatedtype ViewControllerSegue: RawRepresentable
	func segueIdentifierCase(for segue: UIStoryboardSegue) -> ViewControllerSegue
	
}

extension SegueHandler where Self: UIViewController, ViewControllerSegue.RawValue == String {
	
	func segueIdentifierCase(for segue: UIStoryboardSegue) -> ViewControllerSegue {
		guard let identifier = segue.identifier,
			let identifierCase = ViewControllerSegue(rawValue: identifier) else {
				fatalError("Could not map segue identifier -- \(segue.identifier) -- to segue case")
		}
		return identifierCase
	}
	
	
}
