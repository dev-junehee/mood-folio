//
//  Constants.swift
//  mood-folio
//
//  Created by junehee on 7/22/24.
//

import Foundation

enum Constants {
    enum Button {
        static let start = "시작하기"
        static let done = "완료"
    }
    
    enum NavigationTitle {
        static let ProfileSetting = "PROFILE SETTING"
    }
    
    enum Placeholder {
        static let nickname = "닉네임을 입력해 주세요 :)"
    }
    
    enum NicknameValidation: String {
        case success = "사용할 수 있는 닉네임이에요."
        case empty = "닉네임을 입력해 주세요."
        case hasSpecialChar = "닉네임에 @, #, $, %할 포함될 수 없어요."
        case hasNumber = "닉네임에 숫자는 포함할 수 없어요."
        case invalidLength = "2글자 이상 10글자 미만으로 설정해 주세요."
        case same = "이미 사용 중인 닉네임이에요."
        case etc = "알 수 없는 오류에요🥲"
    }
    
    enum Integer {
        static let buttonRadius = 20
        static let  borderWidth = 3
        static let  borderWidthEnabled = 1
    }
}
