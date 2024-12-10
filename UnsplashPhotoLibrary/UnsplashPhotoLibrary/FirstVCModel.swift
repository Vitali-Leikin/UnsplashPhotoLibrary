//
//  MainnModel.swift
//  UnsplashPhotoLibrary
//
//  Created by Vitali on 10/12/2024.
//

import Foundation


class FirstVCModel{
    var isLoading: Observable<Bool> = Observable(false)
    var cellDataSource: Observable<[LoadedModel]> = Observable(nil)
    // var movies: Observable<[CellViewModel]> = Observable(nil)
    private var dataSourse: [LoadedModel] = []
    
  //  private let networkManager = NetworkManager(with: .default)
    
    var network = NetworkManager.shared
    func numberOfSection() -> Int{
        return 0
    }
    
    func numberOfrows() -> Int{
        return dataSourse.count
    }
    
    //
    private func mapMovieData() {
        cellDataSource.value = self.dataSourse
      }

    func getData(){
        network.obtainNewData {[weak self] result in
//            print(result)
            self?.isLoading.value = false
            switch result {
            case .success(let data):
                self?.dataSourse += data
                self?.mapMovieData()
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
