//
//  UIImageAspectRatioExtension.swift
//  QuickBloxTest
//
//  Created by Marc Dermejian on 16/03/2016.
//  Copyright © 2016 Fexco Software Group. All rights reserved.
//

import UIKit

public extension UIImage {
	var aspectRatio: CGFloat {
		return size.height != 0 ? size.width / size.height : 0
	}
}
