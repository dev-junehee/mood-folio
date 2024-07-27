//
//  LikeViewModel.swift
//  mood-folio
//
//  Created by junehee on 7/27/24.
//

import Foundation

final class LikeViewModel {
    
    private let repo = LikePhotoRepository()
    
    // input
    var inputViewDidLoad = Observable<Void?>(nil)
    
    // output
    var outputLikePhotoList = Observable<[LikePhoto]?>([])
    
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewDidLoad.bind { [weak self] _ in
            self?.outputLikePhotoList.value = self?.repo.getAllLikePhoto()
        }
    }
    
}
