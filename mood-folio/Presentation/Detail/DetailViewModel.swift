//
//  DetailViewModel.swift
//  mood-folio
//
//  Created by junehee on 7/25/24.
//

import Foundation

final class DetailViewModel {
    
    private let repo = LikePhotoRepository()
    
    // input
    var inputViewDidLoad = Observable<Void?>(nil)
    var inputPhotoData = Observable<Photo?>(nil)
    var inputHeartButton = Observable<Void?>(nil)
    
    // output
    var outputStatisticsData = Observable<Statistics?>(nil)
    var outputCreateLikePhotoTrigger = Observable<Void?>(nil)
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewDidLoad.bind { [weak self] _ in
            self?.getStatistics()
        }
        
        inputHeartButton.bind { [weak self] _ in
            self?.createLikePhoto()
        }
    }
    
    private func getStatistics() {
        guard let id = inputPhotoData.value?.id else { return }
        print(id)
        
        NetworkManager.shared.callRequest(api: .statistics(imageId: id)) { [weak self] (res: Result<Statistics?, Error>) in
            switch res {
            case .success(let data):
                self?.outputStatisticsData.value = data
                dump(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func createLikePhoto() {
        guard let photo = self.inputPhotoData.value else { return }
        let likePhoto = LikePhoto(photo: photo)
        self.repo.createLikePhoto(likePhoto)
        self.outputCreateLikePhotoTrigger.value = ()
    }
    
}
