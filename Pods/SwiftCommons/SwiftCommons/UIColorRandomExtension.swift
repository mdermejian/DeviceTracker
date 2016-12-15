//
//  UIColorRandomExtension.swift
//  QuickBloxTest
//
//  Created by Marc Dermejian on 15/03/2016.
//  Copyright © 2016 Fexco Software Group. All rights reserved.
//

import UIKit

public extension UIColor {
	public class var random: UIColor {
		switch arc4random() % 5 {
		case 0: return UIColor.green
		case 1: return UIColor.blue
		case 2: return UIColor.orange
		case 3: return UIColor.red
		case 4: return UIColor.purple
		default: return UIColor.black
		}
	}
}
