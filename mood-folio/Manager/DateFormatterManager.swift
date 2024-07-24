//
//  DateFormatterManager.swift
//  mood-folio
//
//  Created by junehee on 7/24/24.
//

import Foundation

final class DateFormatterManager {
    
    private init() { }
    static let shared = DateFormatterManager()
    
    func getTodayString(formatType: String) -> String {
        let today = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        dateFormatter.dateFormat = formatType
        
        let convertedToday = dateFormatter.string(from: today)
        
        return convertedToday
    }
    
}
