//
//  ValidationManager.swift
//  mood-folio
//
//  Created by junehee on 7/24/24.
//

import Foundation

enum NicknameValidation: String, Error {
    case success = "사용할 수 있는 닉네임이에요."
    case empty = ""
    case hasSpecialChar = "닉네임에 @, #, $, %할 포함될 수 없어요."
    case hasNumber = "닉네임에 숫자는 포함할 수 없어요."
    case invalidLength = "2글자 이상 10글자 미만으로 설정해 주세요."
    case same = "이미 사용 중인 닉네임이에요."
    case etc = "알 수 없는 오류에요🥲"
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
            throw NicknameValidation.empty
        } else if hasSpecialChar {
            throw NicknameValidation.hasSpecialChar
        } else if hasNumber {
            throw NicknameValidation.hasNumber
        } else if nickname.count < 2 || nickname.count >= 10 {
            throw NicknameValidation.invalidLength
        } else if nickname == UserDefaultsManager.nickname {
            throw NicknameValidation.same
        } else {
            return true
        }
    }
    
}

