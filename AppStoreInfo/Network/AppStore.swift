//
//  AppStore.swift
//  AppStoreInfo
//
//  Created by jaekyung you on 2021/05/27.
//

import Foundation
import Moya

public enum AppStore {
    case all /// all apps
    case appDetail(appID: String)
}

extension AppStore: TargetType {
    public var baseURL: URL {
        switch self {
        case .all:
            return URL(string: "https://rss.itunes.apple.com/api/v1/kr/ios-apps/top-free")!
        case .appDetail:
            return URL(string: "https://itunes.apple.com")!
        }
    }
    
    public var path: String {
        switch self {
        case .all:
            return "/all/100/explicit.json"
        case .appDetail:
            return "/lookup"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .all, .appDetail:
            return .get
        }
    }
    
    public var sampleData: Data {
        switch self {
        case .all, .appDetail:
            return Data()
        }
    }
    
    public var task: Task {
        switch self {
        case .all :
            return .requestPlain
        case .appDetail(let appID):
            return .requestParameters(parameters: ["id": appID, "country": "kr"],
                                      encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .all, .appDetail:
            return nil
        }
    }

    public var validationType: ValidationType {
        return .successCodes
    }
    
}
