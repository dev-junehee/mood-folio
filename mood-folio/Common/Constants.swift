//
//  Constants.swift
//  mood-folio
//
//  Created by junehee on 7/22/24.
//

import Foundation

enum Constants {
    enum Title {
        static let topic = "OUR TOPIC"
        static let search = "SEARCH PHOTO"
        static let like = "MY POLAROID"
        static let profileSetting = "PROFILE SETTING"
        static let editProfile = "EDIT PROFILE"
    }
    
    enum Topic {
        static let titles = ["골든 아워", "비즈니스 및 업무", "건축 및 인테리어"]
    }
    
    enum Search {
        static let noSearch = "사진을 검색해 보세요!"
        static let noResult = "검색 결과가 없어요!"
        static let placeholder = "키워드 검색"
        static let relevant = "관련순"
        static let latest = "최신순"
    }
    
    enum Profile {
        static let mbti = "MBTI"
    }
    
    enum Button {
        static let start = "시작하기"
        static let okay = "확인"
        static let cancel = "취소"
        static let done = "완료"
    }
    
    enum Placeholder {
        static let nickname = "닉네임을 입력해 주세요 :)"
    }
    
    enum NicknameValidation: String {
        case success = "사용할 수 있는 닉네임이에요."
        case empty = ""
        case hasSpecialChar = "닉네임에 @, #, $, %할 포함될 수 없어요."
        case hasNumber = "닉네임에 숫자는 포함할 수 없어요."
        case invalidLength = "2글자 이상 10글자 미만으로 설정해 주세요."
        case same = "이미 사용 중인 닉네임이에요."
        case etc = "알 수 없는 오류에요🥲"
    }
    
    enum Integer {
        static let commonButtonRadius: CGFloat = 20
        static let mbtiButtonRadius: CGFloat = 40
        static let borderWidth: CGFloat = 3
        static let borderWidthEnabled: CGFloat = 1
    }
}
