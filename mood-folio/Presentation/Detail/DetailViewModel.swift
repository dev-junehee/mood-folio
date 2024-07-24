//
//  DetailViewModel.swift
//  mood-folio
//
//  Created by junehee on 7/25/24.
//

import Foundation

final class DetailViewModel {
    
    // input
    var inputDetailData = Observable<Topic?>(nil)
    var inputViewDidLoad = Observable<Void?>(nil)
    
    // output
    var outputTrigger = Observable<Void?>(nil)
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewDidLoad.bind { [weak self] _ in
            self?.getStatistics()
        }
        
        inputDetailData.bind { [weak self] _ in
            self?.outputTrigger.value = ()
        }
    }
    
    private func getStatistics() {
        
    }
    
}
