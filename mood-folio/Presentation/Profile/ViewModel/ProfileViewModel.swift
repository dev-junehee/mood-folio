//
//  ProfileViewModel.swift
//  mood-folio
//
//  Created by junehee on 7/22/24.
//

import Foundation

enum MBTICharType: String {
    case E, S, T, J, I, N, F, P
    
    var converse: MBTICharType {
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


final class ProfileViewModel {
    
    // input
    var inputViewDidLoad = Observable<Void?>(nil)
    var inputViewWillAppear = Observable<Void?>(nil)
    var inputNicknameTextField = Observable<String?>(nil)
    var inputMBTIButton = Observable<String?>(nil)
    var inputDoneButton = Observable<Void?>(nil)
    
    // input
    var outputProfileImage = Observable<Int>(UserDefaultsManager.shared.profile)
    var outputNicknameResult = Observable<Bool>(false)
    var outputNicknameInvalidMessage = Observable<Constants.NicknameValidation>(.empty)
//    var outputMBTIToggle = Observable<MBTICharType>(.E)
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
//            self?.nicknameValidation()
        }
        
        inputMBTIButton.bind { [weak self] _ in
            self?.toggleMBTIButton()
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
    
    // MBTI 유효성 검사
    private func toggleMBTIButton() {
        guard let mbtiChar = inputMBTIButton.value else { return }
        
        switch mbtiChar {
        case "E":
            print("E")
        case "S":
            print("S")
        case "T":
            print("T")
        case "J":
            print("J")
        case "I":
            print("I")
        case "N":
            print("N")
        case "F":
            print("F")
        case "P":
            print("P")
        default:
            break
        }
    }
    
    // 회원가입
    private func saveUserAccount() {
        // UserDefaults에 유저 데이터 저장
        guard let nickname = inputNicknameTextField.value else { return }
        UserDefaultsManager.shared.nickname = nickname
        UserDefaultsManager.shared.profile = outputProfileImage.value
        UserDefaultsManager.shared.mbti = "INTP"
        UserDefaultsManager.shared.joinDate = DateFormatterManager.shared.getTodayString(formatType: "yyyy. MM. dd")
        UserDefaultsManager.shared.isUser = true
        
        print("잘 저장됐는지 확인")
        print("UD - ", UserDefaultsManager.shared.nickname)
        print("UD - ", UserDefaultsManager.shared.profile)
        print("UD - ", UserDefaultsManager.shared.mbti)
        print("UD - ", UserDefaultsManager.shared.joinDate)
        print("UD - ", UserDefaultsManager.shared.isUser)
        
        outputUserAccountResult.value = true
    }
    
    
}
