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
    var outputLikePhotoList = Observable<[LikePhoto]>([])        // 원본
    var outputLikePhotoListSorted = Observable<[LikePhoto]>([])  // 정렬
    
    init() {
        transform()
    }
    
    private func transform() {
        // 화면이 처음 로드됐을 때
        inputViewDidLoad.bind { [weak self] order in
            let allLikePhoto = self?.repo.getAllLikePhoto()
            self?.outputLikePhotoList.value = allLikePhoto ?? [] // 원본 데이터 저장
            
            switch order {
            case .latest:
                let sorted = self?.outputLikePhotoList.value.sorted { $0.regData > $1.regData }
                self?.outputLikePhotoListSorted.value = sorted ?? []
            case .past:
                let sorted = self?.outputLikePhotoList.value.sorted { $0.regData < $1.regData }
                self?.outputLikePhotoListSorted.value = sorted ?? []
            }
        }
        
        inputViewWillAppear.bind { [weak self] order in
            print("다시뜨나")
            let allLikePhoto = self?.repo.getAllLikePhoto() ?? []
            self?.outputLikePhotoList.value = allLikePhoto // 원본 데이터 저장
            
            switch order {
            case .latest:
                let sorted = self?.outputLikePhotoList.value.sorted { $0.regData > $1.regData }
                self?.outputLikePhotoListSorted.value = sorted ?? []
            case .past:
                let sorted = self?.outputLikePhotoList.value.sorted { $0.regData < $1.regData }
                self?.outputLikePhotoListSorted.value = sorted ?? []
            }
        }
        
        inputSortButton.bind { [weak self] order in
            print("바뀐 값", order)
            guard let originList = self?.outputLikePhotoList.value else { return }
            print(originList)
            
            switch order {
            case .latest:
                let sorted = self?.outputLikePhotoList.value.sorted { $0.regData > $1.regData }
                self?.outputLikePhotoListSorted.value = sorted ?? []
            case .past:
                let sorted = self?.outputLikePhotoList.value.sorted { $0.regData < $1.regData }
                self?.outputLikePhotoListSorted.value = sorted ?? []
            }
        }
        
        inputHeartButton.bind { [weak self] tag in // indexPath.item
            guard let tag else { return }
            let likePhoto = self?.outputLikePhotoList.value[tag]
            print(likePhoto)
            print(self?.outputLikePhotoListSorted.value)
            
            // if let likePhoto {
            //     DocumentFileManager.shared.removeImageFromDocument(filename: likePhoto.id)
            //     self?.repo.deleteLikePhoto(photo: likePhoto)
            //     
            //     self?.outputLikePhotoList.value = self?.repo.getAllLikePhoto() ?? []
            // }
        }
    }
    
}
