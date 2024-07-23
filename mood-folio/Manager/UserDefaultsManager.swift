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
    
    private init() { }
    static var shared = UserDefaultsManager()
    
    @UserDefaultsWrapper (key: .nickname, defaultValue: "손님")
    var nickname: String
    
    @UserDefaultsWrapper (key: .profile, defaultValue: Int.random(in: 0..<Resource.Image.profileImages.count))
    var profile: Int
    
    @UserDefaultsWrapper (key: .mbti, defaultValue: "-")
    var mbti: String
    
    @UserDefaultsWrapper (key: .joinDate, defaultValue: "0000. 00. 00")
    var joinDate: String
    
    @UserDefaultsWrapper (key: .isUser, defaultValue: false)
    var isUser: Bool
    
    func deleteAllUserDefaults() {
        _nickname.delete()
        _profile.delete()
        _mbti.delete()
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
