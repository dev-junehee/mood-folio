//
//  Search.swift
//  mood-folio
//
//  Created by junehee on 7/25/24.
//

import Foundation

struct Search: Decodable {
    let total: Int
    let total_pages: Int
    var results: [Photo]
}
