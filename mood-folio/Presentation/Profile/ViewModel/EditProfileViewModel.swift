//
//  EditProfileViewModel.swift
//  mood-folio
//
//  Created by junehee on 7/26/24.
//

import Foundation

final class EditProfileViewModel {
    
    // input
    var inputViewDidLoad = Observable<Void?>(nil)
    var inputNicknameTextField = Observable<String?>(nil)
    var inputDeleteAccountButton = Observable<Void?>(nil)
    
    // output
    var outputOriginInfo = Observable<(Int, String, [String])>((0, "", ["", "", "", ""]))
    var outputNicknameResult = Observable<Bool>(false)
    var outputNicknameInvalidMessage = Observable<Constants.NicknameValidation>(.empty)
    var outputDeleteAccount = Observable<Void?>(nil)

    init() {
        transform()
    }
    
    private func transform() {
        inputViewDidLoad.bind { [weak self] _ in
            self?.outputOriginInfo.value = (
                UserDefaultsManager.shared.profile,
                UserDefaultsManager.shared.nickname,
                UserDefaultsManager.shared.mbti
            )
        }
        
        inputNicknameTextField.bind { [weak self] _ in
            self?.nicknameValidation()
        }
        
        
        inputDeleteAccountButton.bind { _ in
            print("모든 데이터가 삭제될 예정")
            // Realm 데이터 먼저 삭제
            
            // UserDefaults 데이터 삭제
            UserDefaultsManager.shared.deleteAllUserDefaults()
            self.outputDeleteAccount.value = ()
        }
    }
    
    private func nicknameValidation() {
        guard let nickname = inputNicknameTextField.value else { return }

        do {
            let result = try ValidationManager.shared.getNicknameValidation(nickname)
            if result {
                outputNicknameResult.value = true
                outputNicknameInvalidMessage.value = .success
            }
        } catch  {
            outputNicknameResult.value = false
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
        
}
