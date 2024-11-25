//
//  ImageCache.swift
//  Desafio_TechAcme_ViewCode
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 22/11/24.
//

import Foundation
import UIKit

class ImageCache {
	static let shared = ImageCache()
	private let cache = NSCache<NSString, UIImage>()
	
	private init() {}
	
	func getImage(forKey key: String) -> UIImage? {
		return cache.object(forKey: NSString(string: key))
	}
	
	func saveImage(_ image: UIImage, forKey key: String) {
		cache.setObject(image, forKey: NSString(string: key))
	}
}
