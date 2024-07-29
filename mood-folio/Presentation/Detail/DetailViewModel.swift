//
//  DetailViewModel.swift
//  mood-folio
//
//  Created by junehee on 7/25/24.
//

import UIKit
import Kingfisher

final class DetailViewModel {
    
    private let repo = LikePhotoRepository()
    
    // input
    var inputViewDidLoad = Observable<DetailType>(.photo)
    var inputViewWillAppear = Observable<DetailType>(.photo)
    var inputPhotoData = Observable<Photo?>(nil)
    var inputLikePhotoData = Observable<LikePhoto?>(nil)
    var inputHeartButton = Observable<(DetailType)>(.photo)
    
    var inputSaveImage = Observable<UIImage?>(nil)
    
    // output
    var outputViewWillAppear = Observable<String>("")
    var outputStatisticsData = Observable<Statistics?>(nil)
    var outputCreateLikePhotoTrigger = Observable<Void?>(nil)
    var outputDeleteLikePhotoTrigger = Observable<Void?>(nil)
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewDidLoad.bind { [weak self] type in
            self?.getStatistics(type)
        }
        
        inputViewWillAppear.bind { [weak self] type in
            var id: String?
            
            switch type {
            case .photo:
                id = self?.inputPhotoData.value?.id
            case .likePhoto:
                id = self?.inputLikePhotoData.value?.id
            }
            
            guard let id else { return }
            self?.outputViewWillAppear.value = id
        }
        
        inputHeartButton.bind { [weak self] type in
            var id: String?
            
            switch type {
            case .photo:
                id = self?.inputPhotoData.value?.id
            case .likePhoto:
                id = self?.inputLikePhotoData.value?.id // 찜한 사진에서 찜 해제할 경우 바로 삭제 후 함수 종료
                guard let id else { return }
                self?.deleteLikePhoto(id: id)
                return
            }
            
            guard let id else { return }
            guard let isLikePhoto = self?.repo.isLikePhoto(id: id) else { return }

            if isLikePhoto != true {
                self?.createLikePhoto()
            } else {
                self?.deleteLikePhoto(id: id)
            }
        }
    }
    
    private func getStatistics(_ type: DetailType) {
        var id: String?
        
        switch type {
        case .photo:
            id = self.inputPhotoData.value?.id
        case .likePhoto:
            id = self.inputLikePhotoData.value?.id
        }
        
        guard let id else { return }
        NetworkManager.shared.callRequest(api: .statistics(imageId: id)) { [weak self] (res: Result<Statistics?, Error>) in
            switch res {
            case .success(let data):
                self?.outputStatisticsData.value = data
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func createLikePhoto() {
        guard let photo = self.inputPhotoData.value else { return }
        let likePhoto = LikePhoto(photo: photo)
        self.repo.createLikePhoto(likePhoto)
  
        guard let url = URL(string: photo.urls.raw) else { return }
        DocumentFileManager.shared.saveImageToDocument(imageURL: url, filename: photo.id)
        
        self.outputCreateLikePhotoTrigger.value = ()
    }
    
    private func deleteLikePhoto(id: String) {
        guard let item = self.repo.getLikePhoto(id: id) else { return }
        DocumentFileManager.shared.removeImageFromDocument(filename: id)   // 사진 먼저 삭제
        self.repo.deleteLikePhoto(photo: item)
        self.outputDeleteLikePhotoTrigger.value = ()
    }
    
}
