//
//  CellViewModel.swift
//  UnsplashPhotoLibrary
//
//  Created by Vitali on 10/12/2024.
//

import Foundation
class CellViewModel{
    // MARK: - properties
    var imageUrl: String?
    var id: String
    var isLike: Bool = false
    var fullImageUrl: String?
    var describe: String
    // MARK: - init func
    init(model: LoadedModel) {
        self.imageUrl = model.urls?.thumb
        self.id = model.id!
        self.fullImageUrl = model.urls?.full
        self.describe = model.description ?? ""
        let array =  DataManager.shared.obtainSaveData()
        for item in array{
            if item.id == model.id{
                isLike = true
            }
        }
    }
}

