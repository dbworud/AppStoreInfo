//
//  AppData.swift
//  AppStoreInfo
//
//  Created by jaekyung you on 2021/05/27.
//

import Foundation

struct AppData: Decodable {
    struct Feed: Decodable {
        struct Results: Decodable {
            struct Genres: Decodable {
                var name: String
            }
            var artistName: String
            var id: String
            var name: String
            var rank: Int?
            var genres: [Genres]
            var artworkUrl100: String
        }
        var results: [Results]
    }
    var feed: Feed
}






