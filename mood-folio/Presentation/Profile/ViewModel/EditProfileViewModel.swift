//
//  EditProfileViewModel.swift
//  mood-folio
//
//  Created by junehee on 7/26/24.
//

import Foundation

final class EditProfileViewModel {
    
    private let repo = LikePhotoRepository()
    
    // input
    var inputViewDidLoad = Observable<Void?>(nil)
    var inputNicknameTextField = Observable<String?>(nil)
    var inputActiveMBTIButton = Observable<String?>(nil)    // MBTI 버튼 활성화
    var inputInactiveMBTIButton = Observable<String?>(nil)  // MBTI 버튼 비활성화
    var inputDeleteAccountButton = Observable<Void?>(nil)   // 회원탈퇴 버튼
    
    // output
    var outputOriginInfo = Observable<(Int, String, [String])>((0, "", ["", "", "", ""]))
    var outputNicknameResult = Observable<Bool>(false)
    var outputNicknameInvalidMessage = Observable<Constants.NicknameValidation>(.empty)
    var outputMBTI = Observable<[MBTICharType.RawValue]>(UserDefaultsManager.shared.mbti)
    var outputOppositeMBTI = Observable<MBTICharType?>(.none)
    var outputMBTIResult = Observable<Bool>(false)
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
        
        inputActiveMBTIButton.bind { [weak self] _ in
            self?.setActiveMBTIChar()
        }
        
        inputInactiveMBTIButton.bind { [weak self] _ in
            self?.setInactiveMBTIChar()
        }
        
        inputDeleteAccountButton.bind { [weak self] _ in
            print("모든 데이터가 삭제될 예정")
            DocumentFileManager.shared.removeAllImageFromDocument()
            
            // Realm 데이터 먼저 삭제
            self?.repo.deleteAllRealm()
            
            // UserDefaults 데이터 삭제
            UserDefaultsManager.shared.deleteAllUserDefaults()
            self?.outputDeleteAccount.value = ()
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
    
    // MBTI 값 저장 + 반대 버튼 해제
    private func setActiveMBTIChar() {
        if let label = inputActiveMBTIButton.value, let char = MBTICharType(rawValue: label) {
            switch char {
            case .E, .I:
                self.outputMBTI.value[0] = char.rawValue
            case .S, .N:
                self.outputMBTI.value[1] = char.rawValue
            case .F, .T:
                self.outputMBTI.value[2] = char.rawValue
            case .J, .P:
                self.outputMBTI.value[3] = char.rawValue
            }
            outputOppositeMBTI.value = char.opposite
            self.mbtiValidation()
        } else {
            outputOppositeMBTI.value = .none
        }
    }
    
    private func setInactiveMBTIChar() {
        if let label = inputInactiveMBTIButton.value, let char = MBTICharType(rawValue: label) {
            switch char {
            case .E, .I:
                self.outputMBTI.value[0] = ""
            case .S, .N:
                self.outputMBTI.value[1] = ""
            case .F, .T:
                self.outputMBTI.value[2] = ""
            case .J, .P:
                self.outputMBTI.value[3] = ""
            }
            self.mbtiValidation()
        }
    }
    
    private func mbtiValidation() {
        let mbti = MBTIType(rawValue: self.outputMBTI.value.joined())
        if mbti == nil {
            self.outputMBTIResult.value = false
        } else {
            self.outputMBTIResult.value = true
        }
    }
    
}
