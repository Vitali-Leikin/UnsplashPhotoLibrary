//
//  ImageNetworkManager.swift
//  UnsplashPhotoLibrary
//
//  Created by Vitali on 10/12/2024.
//

import UIKit
class ImageNetworkManager{
    static let shared = ImageNetworkManager()
    private let session: URLSession = URLSession(configuration: .default)
    private init(){}
    
    private  let cache: NSCache <NSURL, NSData> = {
        let myCache = NSCache <NSURL, NSData> ()
        return myCache
    }()
    
    func downloadImage(by urlString: String) async throws -> UIImage?  {
        guard let url = URL(string: urlString) else {return UIImage()}
        
        if let imageData = cache.object(forKey: url as NSURL){
            return UIImage(data: imageData as Data)
        }
        
        let imageDataResponse = try await session.data(from: url)
        cache.setObject(imageDataResponse.0 as NSData, forKey: url as NSURL)
        return UIImage(data: imageDataResponse.0)
    }
}
