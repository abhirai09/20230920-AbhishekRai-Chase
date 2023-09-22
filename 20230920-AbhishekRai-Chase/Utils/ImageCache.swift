//
//  ImageCache.swift
//  WeatherApp
//
//  Created by Abhishek Rai on 21/09/23.
//

import UIKit

class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSURL, UIImage>()
    private init() { }
    
    func getImage(for url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = cache.object(forKey: url as NSURL) {
            completion(cachedImage)
        } else {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data, let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
                self.cache.setObject(image, forKey: url as NSURL)
                completion(image)
            }.resume()
        }
    }
}
