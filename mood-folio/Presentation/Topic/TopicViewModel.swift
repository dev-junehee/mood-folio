//
//  TopicViewModel.swift
//  mood-folio
//
//  Created by junehee on 7/24/24.
//

import Foundation

final class TopicViewModel {
    
    // input
    var inputViewDidLoad = Observable<Void?>(nil)
    
    // output
    var outputProfileImage = Observable<Int>(UserDefaultsManager.shared.profile)
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewDidLoad.bind { [weak self] _ in
            self?.outputProfileImage.value = UserDefaultsManager.shared.profile
        }
    }
    
        
}
