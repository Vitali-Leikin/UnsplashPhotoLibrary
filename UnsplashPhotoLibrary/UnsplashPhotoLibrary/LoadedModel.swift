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
//    let alternativeSlugs: AlternativeSlugs?
//    let createdAt, updatedAt: Date?
   // let promotedAt: String?
    let width, height: Int?
    let description: String?
 //   let color, blurHash, welcome5Description, altDescription: String?
   // let breadcrumbs: [Any?]
    let urls: Urls?
//    let links: Welcome5Links?
  //  let likes: Int?
  //  let likedByUser: Bool?
   // let currentUserCollections: [Any?]
 //   let sponsorship: String?
//    let topicSubmissions: TopicSubmissions?
 //   let assetType: String?
  //  let user: User?
//    let exif: Exif?
//    let location: Location?
 //   let views, downloads: Int?
    enum CodingKeys: String ,CodingKey {
       case description = "alt_description"
        case id = "id"
        case slug = "slug"
        case width = "width"
        case height = "height"
        case urls = "urls"
        }
}
//
//// MARK: - AlternativeSlugs
//struct AlternativeSlugs:Codable {
//    let en, es, ja, fr: String?
//    let it, ko, de, pt: String?
//}
//
//// MARK: - Exif
//struct Exif: Codable {
//    let make, model, name, exposureTime: String?
//    let aperture, focalLength, iso: String?
//}
//
//// MARK: - Welcome5Links
//struct Welcome5Links:Codable {
//    let linksSelf, html, download, downloadLocation: String?
//}
//
//// MARK: - Location
//struct Location:Codable {
//    let name, city, country: String?
//    let position: Position?
//}
//
//// MARK: - Position
//struct Position: Codable {
//    let latitude, longitude: Double?
//}
//
//// MARK: - TopicSubmissions
//struct TopicSubmissions:Codable {
//    let travel: Travel?
//}
//
//// MARK: - Travel
//struct Travel:Codable {
//    let status: String?
//    let approvedOn: Date?
//}
//
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
//    let smallS3: String?
}

//// MARK: - User
//struct User:Codable {
//    let id: String?
//    let updatedAt: Date?
//    let username, name, firstName, lastName: String?
//    let twitterUsername: String?
//    let portfolioURL: String?
//    let bio, location: String?
//    let links: UserLinks?
//    let profileImage: ProfileImage?
//    let instagramUsername: String?
//    let totalCollections, totalLikes, totalPhotos, totalPromotedPhotos: Int?
//    let totalIllustrations, totalPromotedIllustrations: Int?
//    let acceptedTos, forHire: Bool?
//    let social: Social?
//}
//
//// MARK: - UserLinks
//struct UserLinks:Codable {
//    let linksSelf, html, photos, likes: String?
//    let portfolio, following, followers: String?
//}
//
//// MARK: - ProfileImage
//struct ProfileImage:Codable {
//    let small, medium, large: String?
//}
//
//// MARK: - Social
//struct Social: Codable {
//    let instagramUsername: String?
//    let portfolioURL: String?
//    let twitterUsername: String?
//    let paypalEmail: String?
//}

