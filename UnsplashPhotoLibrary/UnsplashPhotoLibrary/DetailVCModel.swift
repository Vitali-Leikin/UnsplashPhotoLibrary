//
//  DetailVCModel.swift
//  UnsplashPhotoLibrary
//
//  Created by Vitali on 10/12/2024.
//

import UIKit

class DetailVCModel:Codable{
    
   
    // MARK: - property
    var imageUrl: String?
    var thumbUrl: String?
    var description: String?
    var id: String?
    var isLike: Bool = false
    var width: Int?
    var height: Int?
    
    init(model: LoadedModel) {
        self.imageUrl = model.urls?.small
        self.description = model.description
        self.id = model.id
        self.thumbUrl = model.urls?.thumb
        self.width = model.width
        self.height = model.height
    }
    // MARK: - public Func
    func obtainSavedData() -> [StorageModel]{
        return  DataManager.shared.obtainSaveData()
    }
    func removeObject(){
        isLike = false
        guard let checkedID = id else{return}
        DataManager.shared.removeOneObject(id: checkedID)
    }
    
    func saveObject(image: UIImage?, object: DetailVCModel?){
        guard let checkedImg = image, let checkedObject = object else{return}
        saveObject1(image: checkedImg, object: checkedObject)
    }
    func saveObject1(image: UIImage, object: DetailVCModel ){
        let imageSave = DataManager.shared.saveImage(image: image)
        guard let checkSaveImg = imageSave, let checkedDescript = object.description, let checkID = object.id else {return}
        let objectSave = StorageModel(imageName: checkSaveImg, description: checkedDescript , id: checkID, isLike: object.isLike)
        
        DataManager.shared.saveData([objectSave])
    }
    
}


