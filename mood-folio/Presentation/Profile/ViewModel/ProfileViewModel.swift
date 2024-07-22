//
//  ProfileViewModel.swift
//  mood-folio
//
//  Created by junehee on 7/22/24.
//

import Foundation

enum ValidationError: Error {
    case empty
    case hasSpecialChar
    case hasNumber
    case invalidLength
    case same
}

final class ProfileViewModel {
    
    // input
    var inputViewWillAppear = Observable<Void?>(nil)
    var inputNicknameTextField = Observable<String?>(nil)
    
    // input
    var outputProfileImage = Observable<Int>(UserDefaultsManager.profile)
    var outputNicknameIsValid = Observable<Bool>(false)
    var outputNicknameInvalidMessage = Observable<Constants.NicknameValidation>(.empty)
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewWillAppear.bind { [weak self] _ in
            self?.outputProfileImage.value = Int.random(in: 0..<Resource.Image.profileImages.count)
        }
        
        inputNicknameTextField.bind { [weak self] _ in
            self?.nicknameValidation()
        }
    }
    
    private func nicknameValidation() {
        guard let nickname = inputNicknameTextField.value else { return }

        do {
            let result = try getValidationResult(nickname)
            if result {
                outputNicknameIsValid.value = true
                outputNicknameInvalidMessage.value = .success
            }
        } catch  {
            outputNicknameIsValid.value = false
            switch error {
            case ValidationError.empty:
                outputNicknameInvalidMessage.value = .empty
            case ValidationError.hasSpecialChar:
                outputNicknameInvalidMessage.value = .hasSpecialChar
            case ValidationError.hasNumber:
                outputNicknameInvalidMessage.value = .hasNumber
            case ValidationError.invalidLength:
                outputNicknameInvalidMessage.value = .invalidLength
            case ValidationError.same:
                outputNicknameInvalidMessage.value = .same
            default:
                break
            }
        }
    }
    
    // 닉네임 유효성 검사
    private func getValidationResult(_ nickname: String) throws -> Bool {
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
            throw ValidationError.empty
        } else if hasSpecialChar {
            throw ValidationError.hasSpecialChar
        } else if hasNumber {
            throw ValidationError.hasNumber
        } else if nickname.count < 2 || nickname.count >= 10 {
            throw ValidationError.invalidLength
        } else if nickname == UserDefaultsManager.nickname {
            throw ValidationError.same
        } else {
            return true
        }
    }
    
}
