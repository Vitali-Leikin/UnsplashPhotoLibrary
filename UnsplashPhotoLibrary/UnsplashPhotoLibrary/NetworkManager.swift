//
//  NetworkManager.swift
//  UnsplashPhotoLibrary
//
//  Created by Vitali on 10/12/2024.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case canNotParseData
}

public class NetworkManager {
    
    static let shared =  NetworkManager()
    private var urlString: String =  "https://api.unsplash.com/photos/?client_id=AksxsEPVe4Zh71nkJF6mXuasV5crK-9QpBG4NlGXtDU&per_page=30&page="
    private init(){}
    private var counter  = 0
    private var countDown = 300
    
    func obtainNewData(completionHandler: @escaping (_ result: Result<[LoadedModel], NetworkError>) -> Void) {
        counter += 1
         if counter >= 300{
             counter = 1
         }
        var str = urlString + String(counter)
        guard let url = URL(string: str) else {
            completionHandler(Result.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, err in
            if err == nil,
               let data = dataResponse,
               let resultData = try? JSONDecoder().decode([LoadedModel].self, from: data) {
                completionHandler(.success(resultData))
            } else {
                print(err.debugDescription)
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
    
    
    func obtainRefreshData(completionHandler: @escaping (_ result: Result<[LoadedModel], NetworkError>) -> Void) {
        countDown -= 1
        if countDown <= 0{
            countDown = 300
         }
        var str = urlString + String(countDown)
        guard let url = URL(string: str) else {
            completionHandler(Result.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, err in
            if err == nil,
               let data = dataResponse,
               let resultData = try? JSONDecoder().decode([LoadedModel].self, from: data) {
                completionHandler(.success(resultData))
            } else {
                print(err.debugDescription)
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
}
