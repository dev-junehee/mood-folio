//
//  ProfileViewModel.swift
//  mood-folio
//
//  Created by junehee on 7/22/24.
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

final class ProfileViewModel {
    
    // input
    var inputViewDidLoad = Observable<Void?>(nil)
    var inputViewWillAppear = Observable<Void?>(nil)
    var inputNicknameTextField = Observable<String?>(nil)
    var inputMBTIButton = Observable<String?>(nil)
    var inputDoneButton = Observable<Void?>(nil)
    
    // input
    var outputProfileImage = Observable<Int>(UserDefaultsManager.shared.profile)
    var outputNicknameIsValid = Observable<Bool>(false)
    var outputNicknameInvalidMessage = Observable<Constants.NicknameValidation>(.empty)
    var outputMBTIIsValid = Observable<Bool>(false)
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewDidLoad.bind { [weak self] _ in
            UserDefaultsManager.shared.profile = Int.random(in: 0..<Resource.Image.profileImages.count)
            self?.outputProfileImage.value = UserDefaultsManager.shared.profile
        }
        
        inputViewWillAppear.bind { [weak self] _ in
            self?.outputProfileImage.value = UserDefaultsManager.shared.profile
        }
        
        inputNicknameTextField.bind { [weak self] _ in
            self?.nicknameValidation()
        }
        
        inputMBTIButton.bind { [weak self] mbtiChar in
            self?.mbtiValidation()
        }
        
        inputDoneButton.bind { [weak self] _ in
            print("가입 전 확인")
            print("프로필 이미지", self?.outputProfileImage.value)
            print("닉네임", self?.inputNicknameTextField.value)
            // print("MBTI")
            
            self?.saveUserAccount()
        }
    }
    
    private func nicknameValidation() {
        guard let nickname = inputNicknameTextField.value else { return }

        do {
            let result = try getNicknameValidationResult(nickname)
            if result {
                outputNicknameIsValid.value = true
                outputNicknameInvalidMessage.value = .success
            }
        } catch  {
            outputNicknameIsValid.value = false
            switch error {
            case NicknameValidationError.empty:
                outputNicknameInvalidMessage.value = .empty
            case NicknameValidationError.hasSpecialChar:
                outputNicknameInvalidMessage.value = .hasSpecialChar
            case NicknameValidationError.hasNumber:
                outputNicknameInvalidMessage.value = .hasNumber
            case NicknameValidationError.invalidLength:
                outputNicknameInvalidMessage.value = .invalidLength
            case NicknameValidationError.same:
                outputNicknameInvalidMessage.value = .same
            default:
                break
            }
        }
    }
    
    // 닉네임 유효성 검사
    private func getNicknameValidationResult(_ nickname: String) throws -> Bool {
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
    private func mbtiValidation() {
        guard let mbtiChar = inputMBTIButton.value else { return }
        print(mbtiChar)
    }
    
    // 회원가입
    private func saveUserAccount() {
        // UserDefaults에 유저 데이터 저장
    }
    
    
}
