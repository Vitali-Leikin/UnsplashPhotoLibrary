//
//  DataManager.swift
//  UnsplashPhotoLibrary
//
//  Created by Vitali on 10/12/2024.
//

import UIKit
class DataManager{
    // MARK: - property
    private let userDefaults = UserDefaults(suiteName: "local")
    private let userKey = "key"
    static let shared = DataManager()
    
    // MARK: - private func
    private func saveDataINside(_ object:[StorageModel]){
        do{
            let encoder = JSONEncoder()
            let dataUsers = try encoder.encode( object)
            userDefaults?.setValue(dataUsers, forKey: userKey)
        }catch{
            print("Error save" , error.localizedDescription)
        }
    }
    // MARK: - DELETE public func
    func removeOneObject(id: String){
        let array = obtainSaveData()
        var tempArr: [StorageModel] = []
        for item in array{
            if item.id != id{
                tempArr.append(item)
            }
        }
        saveDataINside(tempArr)
    }
    
    func removeAllObject(){
        saveDataINside([])
    }
    // MARK: - Save public func
    func saveData(_ object:[StorageModel]){
        var array = obtainSaveData()
        array += object
        do{
            let encoder = JSONEncoder()
            let dataUsers = try encoder.encode( array)
            userDefaults?.setValue(dataUsers, forKey: userKey)
        }catch{
            print("Error save" , error.localizedDescription)
        }
    }
    func saveObjectDeatil(image: UIImage, object: DetailVCModel ){
        let imageSave = DataManager.shared.saveImage(image: image)
        guard let checkSaveImg = imageSave, let checkedDescript = object.description, let checkID = object.id else {return}
        let objectSave = StorageModel(imageName: checkSaveImg, description: checkedDescript , id: checkID, isLike: object.isLike)
        DataManager.shared.saveData([objectSave])
    }
    
    func saveCellobject(object: CellViewModel){
        guard let safeImage = object.imageUrl else{print(NetworkError.canNotParseData)
            return}
        Task{
            do{
                let img = try await ImageNetworkManager.shared.downloadImage(by: safeImage)
                guard let savedImg = img else{return}
                let imageSave = DataManager.shared.saveImage(image: savedImg)
                guard let checkedImg = imageSave else{return}
                
                let objectSave = StorageModel(imageName: checkedImg, description: object.describe, id: object.id, isLike: object.isLike)
                DataManager.shared.saveData([objectSave])
            }catch{
                print(NetworkError.canNotParseData)
            }
        }
    }
    
    func saveImage(image: UIImage) -> String? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        
        let fileName = UUID().uuidString
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return nil}
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
            } catch let removeError {
                print("error remove",removeError.localizedDescription )
            }
        }
        do {
            try data.write(to: fileURL)
            return fileName
        } catch let error {
            print("error write file",error.localizedDescription )
            return nil
        }
    }
    // MARK: - obtain and load public func
    func obtainSaveData() -> [StorageModel]{
        guard let users = userDefaults?.data(forKey: userKey) else {return []}
        do{
            let decoder = JSONDecoder()
            let dataUsers = try decoder.decode( [StorageModel].self, from: users)
            return dataUsers
        }catch{
            print("Error save" , error.localizedDescription)
        }
        return []
    }

    func loadImage(fileName:String) -> UIImage? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image
        }
        return nil
    }
}
