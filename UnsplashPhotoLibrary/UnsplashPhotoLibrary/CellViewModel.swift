//
//  CellViewModel.swift
//  UnsplashPhotoLibrary
//
//  Created by Vitali on 10/12/2024.
//

import Foundation
class CellViewModel{
    var imageUrl: String?
    var isLike: Bool = false
    
    init(model: LoadedModel) {
        self.imageUrl = model.urls?.thumb
        let array =  DataManager.shared.obtainSaveData()
        for item in array{
            if item.id == model.id{
                isLike = true
                print("true")
            }
        }
    }
}
