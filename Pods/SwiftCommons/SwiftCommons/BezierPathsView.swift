//
//  BezierPathsView.swift
//  QuickBloxTest
//
//  Created by Marc Dermejian on 15/03/2016.
//  Copyright © 2016 Fexco Software Group. All rights reserved.
//

import UIKit

open class BezierPathsView: UIView {
	
	private var bezierPaths = [String:UIBezierPath]()
	
	open func setPath(_ path: UIBezierPath?, named name: String){
		bezierPaths[name] = path
		setNeedsDisplay()
	}
	
	override open func draw(_ rect: CGRect) {
		for (_, path) in bezierPaths{
			path.stroke()
		}
	}
}
