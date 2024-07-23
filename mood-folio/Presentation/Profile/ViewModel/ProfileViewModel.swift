//
//  ProfileViewModel.swift
//  mood-folio
//
//  Created by junehee on 7/22/24.
//

import Foundation

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
            let result = try ValidationManager.shared.getNicknameValidation(nickname)
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
