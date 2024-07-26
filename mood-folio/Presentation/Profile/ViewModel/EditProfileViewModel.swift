//
//  EditProfileViewModel.swift
//  mood-folio
//
//  Created by junehee on 7/26/24.
//

import Foundation

final class EditProfileViewModel {
    
    // input
    var inputViewDidLoad = Observable<Void?>(nil)
    var inputDeleteAccountButton = Observable<Void?>(nil)
    
    // output
    var outputOriginInfo = Observable<(Int, String, [String])>((0, "", ["", "", "", ""]))
    var outputDeleteAccount = Observable<Void?>(nil)

    init() {
        transform()
    }
    
    private func transform() {
        inputViewDidLoad.bind { [weak self] _ in
            self?.outputOriginInfo.value = (
                UserDefaultsManager.shared.profile,
                UserDefaultsManager.shared.nickname,
                UserDefaultsManager.shared.mbti
            )
        }
        
        inputDeleteAccountButton.bind { _ in
            print("모든 데이터가 삭제될 예정")
            // Realm 데이터 먼저 삭제
            
            // UserDefaults 데이터 삭제
            UserDefaultsManager.shared.deleteAllUserDefaults()
            self.outputDeleteAccount.value = ()
        }
    }
        
}
