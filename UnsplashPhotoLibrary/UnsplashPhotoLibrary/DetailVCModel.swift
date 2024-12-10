//
//  DetailVCModel.swift
//  UnsplashPhotoLibrary
//
//  Created by Vitali on 10/12/2024.
//

import UIKit

class DetailVCModel:Codable{
    var imageUrl: String?
    var thumbUrl: String?
    var description: String?
    var id: String?
    var isLike: Bool = false
    var width: Int
    var height: Int
    init(model: LoadedModel) {
        self.imageUrl = model.urls?.small
        self.description = model.description
        self.id = model.id
        self.thumbUrl = model.urls?.thumb
        self.width = model.width!
        self.height = model.height!
    }
    func obtainSavedData() -> [StorageModel]{
        return  DataManager.shared.obtainSaveData()
    }
    func removeObject(){
        print("remove")
        isLike = false
        DataManager.shared.deleteOneObject(id: id!)
    }
    func saveObject(image: UIImage? ){
        guard let img = image else{return}
        let imageSave = DataManager.shared.saveImage(image: img)
        guard let checkSaveImg = imageSave, let describ = description, let checkID = id else {return}
        let objectSave = StorageModel(imageName: checkSaveImg, description: describ, id: checkID, isLike: isLike)
        DataManager.shared.saveData([objectSave])
    }
    
}
