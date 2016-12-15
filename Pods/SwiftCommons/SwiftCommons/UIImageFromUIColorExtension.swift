//
//  UIImageFromUIColorExtension.swift
//  SwiftCommons
//
//  Created by Marc Dermejian on 23/05/2016.
//  Copyright © 2016 Marc Dermejian. All rights reserved.
//

import Foundation

public extension UIImage {
	public static func image(withColor color: UIColor) -> UIImage {
		let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
		UIGraphicsBeginImageContext(rect.size)
		let context = UIGraphicsGetCurrentContext()
		
		context!.setFillColor(color.cgColor)
		context!.fill(rect)
		
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return image!
	}
}
