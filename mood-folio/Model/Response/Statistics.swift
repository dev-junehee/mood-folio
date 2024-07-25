//
//  Statistics.swift
//  mood-folio
//
//  Created by junehee on 7/25/24.
//

import Foundation

struct Statistics: Decodable {
    let id: String
    let downloads: StatisticsDownload
    let views: StatisticsViews
}

struct StatisticsDownload: Decodable {
    let total: Int
    let historical: StatisticsHistorical
}

struct StatisticsHistorical: Decodable {
    let values: [HistoricalValues]
}

struct HistoricalValues: Decodable {
    let date: String
    let value: Int
}

struct StatisticsViews: Decodable {
    let total: Int
    let historical: StatisticsHistorical
}
