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
    case isUser
}

struct UserDefaultsManager {
    @UserDefaultsWrapper (key: .nickname, defaultValue: "손님")
    static var nickname: String
    
    @UserDefaultsWrapper (key: .profile, defaultValue: Int.random(in: 0..<Resource.Image.profileImages.count))
    static var profile: Int
    
    @UserDefaultsWrapper (key: .isUser, defaultValue: false)
    static var isUser: Bool
    
    static func deleteAllUserDefaults() {
        _nickname.delete()
        _profile.delete()
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
