//
//  UIImageViewFromURLExtension.swift
//  SwiftCommons
//
//  Created by Marc Dermejian on 06/05/2016.
//  Copyright © 2016 Marc Dermejian. All rights reserved.
//

import Foundation

public extension UIImageView {
	
	public func image(fromUrlString urlString: String, placeholderImage: UIImage?) {
		
		image = placeholderImage
		if let url = NSURL(string: urlString) {
			image(fromUrl: url, placeholderImage: placeholderImage)
		}
	}
	
	public func image(fromUrl url: NSURL, placeholderImage: UIImage?) {
		
		image = placeholderImage
		
		let task = URLSession.shared.dataTask(with: url as URL) {
			(data, response, error) in
			DispatchQueue.main.async {
				self.image = UIImage(data: data!)
			}
		}
		task.resume()
	}
}
