//
//  AppDetailData.swift
//  AppStoreInfo
//
//  Created by jaekyung you on 2021/05/27.
//

import Foundation

struct AppDetailData: Decodable {
    struct Results: Decodable {
        var appID: Int
        var artworkUrl100: String
        var title: String
        var genres: [String]
        var age: String
        var rank: Int?
        var reviewCount: Int
        var rating: Double
        var version: String
        var releaseNotes: String
        var description: String
        var artistName: String
        var screenshotUrls: [String]
        
        enum CodingKeys: String, CodingKey {
            case appID = "trackId"
            case title = "trackCensoredName"
            case age = "contentAdvisoryRating"
            case reviewCount = "userRatingCount"
            case rating = "averageUserRating"
            
            case artworkUrl100, genres, rank, version, releaseNotes, description, artistName, screenshotUrls
        }
    }
    
    var results: [Results]
}

// https://apps.apple.com/kr/app/%EC%BF%A0%ED%8C%A1%EC%9D%B4%EC%B8%A0/id1445504255

