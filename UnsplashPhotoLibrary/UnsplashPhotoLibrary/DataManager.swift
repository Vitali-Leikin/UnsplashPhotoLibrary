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
    
    func saveCellobject(object: CellViewModel){
        guard let safeImage = object.fullImageUrl else{print(NetworkError.canNotParseData)
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
                NetworkError.canNotParseData
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
             //   print("Removed old image")
            } catch let removeError {
              //  print("couldn't remove file at path", removeError)
            }
        }
        
        do {
            try data.write(to: fileURL)
            return fileName
        } catch let error {
        //    print("error saving file with error", error)
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
