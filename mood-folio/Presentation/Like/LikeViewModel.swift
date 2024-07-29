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
    var inputHeartButton = Observable<(String, LikeOrder)>(("", .latest))
    
    // output
    var outputLikePhotoList = Observable<[LikePhoto]>([])              // 원본
    
    var outputLikePhotoListSortedLatest = Observable<[LikePhoto]>([])  // 최신순
    var outputLikePhotoListSortedPast = Observable<[LikePhoto]>([])    // 관련순
    var outputLikePhotoListSorted = Observable<[LikePhoto]>([])        // 실제 보여줄 값
    
    init() {
        transform()
    }
    
    private func transform() {
        // 화면이 처음 로드됐을 때
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
            print("바뀐 값", order)
            
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
        
        inputHeartButton.bind { [weak self] (id, order) in
            print("id", id)
            
            // 앱이 계속 종료되는 오류..발생...
            guard let likePhoto = self?.repo.getLikePhoto(id: id) else { return }
            DocumentFileManager.shared.removeImageFromDocument(filename: likePhoto.id)
            self?.repo.deleteLikePhoto(photo: likePhoto)
            self?.outputLikePhotoList.value = self?.repo.getAllLikePhoto() ?? []
        }
    }
    
}
