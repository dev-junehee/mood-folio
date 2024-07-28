//
//  Constants.swift
//  mood-folio
//
//  Created by junehee on 7/22/24.
//

import Foundation

enum Constants {
    static let moodfolio = "moodfolio"
    
    enum Title {
        static let topic = "OUR TOPIC"
        static let search = "SEARCH PHOTO"
        static let like = "MY MOOD FOLIO"
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
    
    enum Like {
        static let latest = "최신순"
        static let past = "과거순"
    }
    
    enum Detail {
        static let info = "정보"
        static let size = "크기"
        static let view = "조회수"
        static let download = "다운로드"
    }
    
    enum Profile {
        static let mbti = "MBTI"
    }
    
    enum Button {
        static let start = "시작하기"
        static let okay = "확인"
        static let cancel = "취소"
        static let done = "완료"
        static let save = "저장"
        static let cancelation = "회원탈퇴"
    }
    
    enum Placeholder {
        static let nickname = "닉네임을 입력해 주세요 :)"
    }
    
    enum Alert {
        enum Welcome {
            static let message = "무드폴리오를 찾아주셔서 감사해요!✨"
        }
        
        enum EditProfile {
            static let title = "프로필 수정 완료"
            static let message = "프로필 성공적으로 수정되었어요!\n이전 화면으로 돌아갈게요."
        }
        
        enum Cancelation {
            static let title = "정말 떠나시는 건가요?"
            static let message = "탈퇴하면 저장된 데이터가 모두 초기화돼요.\n그래도 탈퇴하시겠어요?"
        }
        
        enum ToOnboarding {
            static let title = "회원탈퇴 완료"
            static let message = "그동안 무드폴리오를 이용해 주셔서 감사해요.\n언제든 다시 찾아주세요.👋"
        }
    }
    
    enum Integer {
        static let commonButtonRadius: CGFloat = 20
        static let mbtiButtonRadius: CGFloat = 40
        static let borderWidth: CGFloat = 3
        static let borderWidthEnabled: CGFloat = 1
    }
}
