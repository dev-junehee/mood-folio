//
//  EditProfileImageViewModel.swift
//  mood-folio
//
//  Created by junehee on 7/26/24.
//

import Foundation

final class EditProfileImageViewModel {
    
    // input
    var inputViewDidLoad = Observable<Void?>(nil)
    var inputProfileImageSelected = Observable<Int?>(nil)
    
    // output
    var outputOriginProfileImage = Observable<Int>(UserDefaultsManager.shared.profile)
    var outputChangedProfileImage = Observable<Int>(UserDefaultsManager.shared.profile)
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewDidLoad.bind { [weak self] _ in
            self?.outputOriginProfileImage.value = UserDefaultsManager.shared.profile
        }
        
        inputProfileImageSelected.bind { [weak self] selected in
            guard let selected else { return }
            print("선택한 이미지", selected)
            self?.outputChangedProfileImage.value = selected
        }
    }
    
}
