//
//  UserDefaultsManager.swift
//  mood-folio
//
//  Created by junehee on 7/22/24.
//

import Foundation

enum UserDefaultsKey: String {
    case nickname
    case profile
    case mbti
    case joinDate
    case isUser
}

struct UserDefaultsManager {
    
    @UserDefaultsWrapper (key: .nickname, defaultValue: "손님")
    static var nickname: String
    
    @UserDefaultsWrapper (key: .profile, defaultValue: Int.random(in: 0..<Resource.Image.profileImages.count))
    static var profile: Int
    
    @UserDefaultsWrapper (key: .mbti, defaultValue: ["", "", "", ""])
    static var mbti: [String]
    
    @UserDefaultsWrapper (key: .joinDate, defaultValue: "0000. 00. 00")
    static var joinDate: String
    
    @UserDefaultsWrapper (key: .isUser, defaultValue: false)
    static var isUser: Bool
    
    static func getWelcomeMessage() -> String {
        return "환영합니다, \(UserDefaultsManager.nickname)님!"
    }
    
    static func deleteAllUserDefaults() {
        _nickname.delete()
        _profile.delete()
        _mbti.delete()
        _joinDate.delete()
        _isUser.delete()
    }
    
}

@propertyWrapper
struct UserDefaultsWrapper<T> {
    
    let key: UserDefaultsKey
    let defaultValue: T
    
    init(key: UserDefaultsKey, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key.rawValue) as? T ?? defaultValue
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: key.rawValue)
        }
    }
    
    func delete() {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
}
