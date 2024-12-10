//
//  WorksModel.swift
//  UnsplashPhotoLibrary
//
//  Created by Vitali on 10/12/2024.
//

import Foundation

struct StorageModel: Codable {
    var imageName: String
    var description: String
    var id: String
    var isLike: Bool
}
