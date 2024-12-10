//
//  MainnModel.swift
//  UnsplashPhotoLibrary
//
//  Created by Vitali on 10/12/2024.
//

import Foundation


class FirstVCModel{
    // MARK: property
    var cellDataSource: Observable<[LoadedModel]> = Observable(nil)
    private var dataSourse: [LoadedModel] = []
    private var network = NetworkManager.shared
 
    private func mapLoadedData() {
        cellDataSource.value = self.dataSourse
      }
    // MARK: funcs get data
    func getData(){
        network.obtainNewData {[weak self] result in
            switch result {
            case .success(let data):
                self?.dataSourse += data
                self?.mapLoadedData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getRefreshData(){
        network.obtainRefreshData{[weak self] result in
            switch result {
            case .success(let data):
                self?.dataSourse = data
                self?.mapLoadedData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
