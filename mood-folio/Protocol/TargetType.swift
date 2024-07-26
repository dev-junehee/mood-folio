//
//  TargetType.swift
//  mood-folio
//
//  Created by junehee on 7/26/24.
//

import Foundation
import Alamofire

protocol TargetType {
    var base: String { get }
    var endPoint: URL { get }
    var method: HTTPMethod { get }
    var params: Parameters { get }
}
