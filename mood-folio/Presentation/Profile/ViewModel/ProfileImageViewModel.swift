//
//  ProfileImageViewModel.swift
//  mood-folio
//
//  Created by junehee on 7/24/24.
//

import Foundation

final class ProfileImageViewModel {
    
    // input
    var inputViewWillAppear = Observable<Void?>(nil)
    var inputProfileImageSelected = Observable<Int?>(nil)
    
    // output
    var outputProfileImage = Observable<Int>(UserDefaultsManager.profile)
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewWillAppear.bind { [weak self] _ in
            self?.outputProfileImage.value = UserDefaultsManager.profile
        }
        
        inputProfileImageSelected.bind { [weak self] selected in
            guard let selected else { return }
            UserDefaultsManager.profile = selected
            self?.outputProfileImage.value = UserDefaultsManager.profile
        }
        
    }
}
