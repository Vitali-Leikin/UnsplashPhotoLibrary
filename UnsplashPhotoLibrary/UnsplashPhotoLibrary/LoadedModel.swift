//
//  LoadedModel.swift
//  UnsplashPhotoLibrary
//
//  Created by Vitali on 10/12/2024.
//

import Foundation


// MARK: - Welcome5Element
struct LoadedModel: Codable, Identifiable {
    let id, slug: String?
    let width, height: Int?
    let description: String?
    let urls: Urls?
    
    enum CodingKeys: String ,CodingKey {
        case description = "alt_description"
        case id = "id"
        case slug = "slug"
        case width = "width"
        case height = "height"
        case urls = "urls"
    }
}
// MARK: - Urls
struct Urls: Codable {
    let raw, full, regular, small: String?
    let thumb: String?
    
    enum CodingKeys: String ,CodingKey {
        case raw = "raw"
        case full = "full"
        case regular = "regular"
        case small = "small"
        case thumb = "thumb"
    }
}
