//
//  APIcase.swift
//  mood-folio
//
//  Created by junehee on 7/24/24.
//

import Foundation
import Alamofire

enum SearchOrder: String {
    case relevant
    case latest
}

enum Router {
    case topic(topicId: String)
    case search(query: String, page: Int, order: SearchOrder)
    case statistics(imageId: String)
}

extension Router: TargetType {
    
    var base: String {
        return API.URL.base
    }
    
    var endPoint: URL {
        switch self {
        case .topic(let topicId):
            return URL(string: base + API.URL.topic + topicId + "/photos")!
        case .search:
            return URL(string: base + API.URL.search)!
        case .statistics(let imageId):
            return URL(string: base + API.URL.statistics + imageId + "/statistics")!
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var params: Parameters {
        switch self {
        case .topic:
            return [
                API.Param.page: 1,
                API.Param.client: API.KEY.key
            ]
        case .search(let query, let page, let order):
            return [
                API.Param.query: query,
                API.Param.page: page,
                API.Param.perPage: 20,
                API.Param.order: order.rawValue,
//                API.Param.color: "white",
                API.Param.client: API.KEY.key
            ]
        case .statistics:
            return [
                API.Param.client: API.KEY.key
            ]
        }
    }
}
