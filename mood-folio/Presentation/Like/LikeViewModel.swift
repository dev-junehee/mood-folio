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
    var inputViewDidLoad = Observable<LikeOrder>(.latest)
    var inputViewWillAppear = Observable<LikeOrder>(.latest)
    var inputSortButton = Observable<LikeOrder>(.latest)
    var inputHeartButton = Observable<Int?>(nil)
    
    // output
    var outputLikePhotoList = Observable<[LikePhoto]?>([])
    
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewDidLoad.bind { [weak self] order in
            let allLikePhoto = self?.repo.getAllLikePhoto() ?? []
            
            switch order {
            case .latest:
                let sorted = allLikePhoto.sorted { $0.regData > $1.regData }
                self?.outputLikePhotoList.value = sorted
            case .past:
                let sorted = allLikePhoto.sorted { $0.regData < $1.regData }
                self?.outputLikePhotoList.value = sorted
            }
        }
        
        inputViewWillAppear.bind { [weak self] order in
            let allLikePhoto = self?.repo.getAllLikePhoto() ?? []
            
            switch order {
            case .latest:
                let sorted = allLikePhoto.sorted { $0.regData > $1.regData }
                self?.outputLikePhotoList.value = sorted
            case .past:
                let sorted = allLikePhoto.sorted { $0.regData < $1.regData }
                self?.outputLikePhotoList.value = sorted
            }
        }
        
        inputSortButton.bind { [weak self] order in
            guard let originList = self?.outputLikePhotoList.value else { return }
            switch order {
            case .latest:
                let sorted = originList.sorted { $0.regData > $1.regData }
                self?.outputLikePhotoList.value = sorted
            case .past:
                let sorted = originList.sorted { $0.regData < $1.regData }
                self?.outputLikePhotoList.value = sorted
            }
        }
        
        inputHeartButton.bind { [weak self] tag in
            guard let tag else { return }
            let likePhoto = self?.outputLikePhotoList.value?[tag]
            
            if let likePhoto {
                self?.repo.deleteLikePhoto(photo: likePhoto)
                self?.outputLikePhotoList.value = self?.repo.getAllLikePhoto() ?? []
            } else {
                
            }
        }
    }
    
}
