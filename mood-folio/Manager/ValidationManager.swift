//
//  ValidationManager.swift
//  mood-folio
//
//  Created by junehee on 7/24/24.
//

import Foundation

enum NicknameValidationError: Error {
    case empty
    case hasSpecialChar
    case hasNumber
    case invalidLength
    case same
}

enum MBTIValidation {
    
}

final class ValidationManager {
    
    private init() { }
    static let shared = ValidationManager()
    
    // 닉네임 유효성 검사
    func getNicknameValidation(_ nickname: String) throws -> Bool {
        let specialChars = ["@", "#", "$", "%"]
        let numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        
        var hasSpecialChar = false
        var hasNumber = false
        
        for char in specialChars {
            for num in numbers {
                if nickname.contains(char) {
                    hasSpecialChar = true
                }
                if nickname.contains(num) {
                    hasNumber = true
                }
            }
        }
        
        if nickname.isEmpty || nickname.trimmingCharacters(in: .whitespaces).isEmpty {
            throw NicknameValidationError.empty
        } else if hasSpecialChar {
            throw NicknameValidationError.hasSpecialChar
        } else if hasNumber {
            throw NicknameValidationError.hasNumber
        } else if nickname.count < 2 || nickname.count >= 10 {
            throw NicknameValidationError.invalidLength
        } else if nickname == UserDefaultsManager.shared.nickname {
            throw NicknameValidationError.same
        } else {
            return true
        }
    }
    
    // MBTI 유효성 검사
    func getMBTIValidation(_ mbtiChar: String) {
        
    }
    
}

