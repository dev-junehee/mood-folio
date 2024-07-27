//
//  LikeViewModel.swift
//  mood-folio
//
//  Created by junehee on 7/27/24.
//

import Foundation

enum LikeOrder {
    case latest
    case past
}

final class LikeViewModel {
    
    private let repo = LikePhotoRepository()
    
    // input
    var inputViewWillAppear = Observable<LikeOrder>(.latest)
    var inputSortButton = Observable<LikeOrder>(.latest)
    
    // output
    var outputLikePhotoList = Observable<[LikePhoto]>([])
    
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewWillAppear.bind { [weak self] order in
            switch order {
            case .latest:
                let allLikePhoto: [LikePhoto] = self?.repo.getAllLikePhoto() ?? []
                let sorted = allLikePhoto.sorted { $0.regData > $1.regData }
                self?.outputLikePhotoList.value = sorted
            case .past:
                let allLikePhoto: [LikePhoto] = self?.repo.getAllLikePhoto() ?? []
                let sorted = allLikePhoto.sorted { $0.regData < $1.regData }
                self?.outputLikePhotoList.value = sorted
            }
        }
        
        inputSortButton.bind { [weak self] order in
            switch order {
            case .latest:
                let sorted = self?.outputLikePhotoList.value.sorted { $0.regData > $1.regData }
                self?.outputLikePhotoList.value = sorted ?? []
            case .past:
                let sorted = self?.outputLikePhotoList.value.sorted { $0.regData < $1.regData }
                self?.outputLikePhotoList.value = sorted ?? []
            }
        }
    }
    
}
