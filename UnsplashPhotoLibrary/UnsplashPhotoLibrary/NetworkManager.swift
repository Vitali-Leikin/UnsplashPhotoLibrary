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
    private init(){}
    var counter  = 0
    
    func obtainNewData(completionHandler: @escaping (_ result: Result<[LoadedModel], NetworkError>) -> Void) {
        counter += 1
         if counter >= 300{
             counter = 1
         }
        
        print("counter = \(counter)")
        let urlString: String =  "https://api.unsplash.com/photos/?client_id=AksxsEPVe4Zh71nkJF6mXuasV5crK-9QpBG4NlGXtDU&per_page=30&page=\(String(counter))"
        guard let url = URL(string: urlString) else {
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
