//
//  ProfileViewModel.swift
//  mood-folio
//
//  Created by junehee on 7/22/24.
//

import Foundation

enum MBTICharType: String {
    case E, S, T, J, I, N, F, P
    
    var opposite: MBTICharType {
        switch self {
        case .E: return .I
        case .S: return .N
        case .T: return .F
        case .J: return .P
        case .I: return .E
        case .N: return .S
        case .F: return .T
        case .P: return .J
        }
    }
}

enum MBTIType: String {
    case ESTJ, ESTP, ESFJ, ESFP, ENTP, ENTJ, ENFJ, ENFP
    case INTP, INTJ, INFP, INFJ, ISTP, ISTJ, ISFP, ISFJ
}

final class ProfileViewModel {
    
    // input
    var inputViewDidLoad = Observable<Void?>(nil)
    var inputViewWillAppear = Observable<Void?>(nil)
    var inputNicknameTextField = Observable<String?>(nil)
    var inputActiveMBTIButton = Observable<String?>(nil)    // MBTI 버튼 활성화
    var inputInactiveMBTIButton = Observable<String?>(nil)  // MBTI 버튼 비활성화
    var inputDoneButton = Observable<Void?>(nil)
    
    // output
    var outputProfileImage = Observable<Int>(UserDefaultsManager.shared.profile)
    var outputNicknameResult = Observable<Bool>(false)
    var outputNicknameInvalidMessage = Observable<Constants.NicknameValidation>(.empty)
    var outputMBTI = Observable<[MBTICharType.RawValue]>(["", "", "", ""])
    var outputOppositeMBTI = Observable<MBTICharType?>(.none)
    var outputMBTIResult = Observable<Bool>(false)
    var outputUserAccountResult = Observable<Bool>(false)
    
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
        
        inputActiveMBTIButton.bind { [weak self] _ in
            self?.setActiveMBTIChar()
        }
        
        inputInactiveMBTIButton.bind { [weak self] _ in
            self?.setInactiveMBTIChar()
        }
        
        inputDoneButton.bind { [weak self] _ in
            self?.saveUserAccount()
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
    
    // 회원가입
    private func saveUserAccount() {
        // UserDefaults에 유저 데이터 저장
        guard let nickname = inputNicknameTextField.value else { return }
        
        UserDefaultsManager.shared.nickname = nickname
        UserDefaultsManager.shared.profile = outputProfileImage.value
        UserDefaultsManager.shared.mbti = outputMBTI.value
        UserDefaultsManager.shared.joinDate = DateFormatterManager.shared.getTodayString(formatType: "yyyy. MM. dd")
        UserDefaultsManager.shared.isUser = true
        
        outputUserAccountResult.value = true
    }
    
}
