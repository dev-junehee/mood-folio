//
//  DetailViewModel.swift
//  mood-folio
//
//  Created by junehee on 7/25/24.
//

import Foundation

final class DetailViewModel {
    
    // input
    var inputViewDidLoad = Observable<Void?>(nil)
    var inputPhotoData = Observable<Photo?>(nil)
    
    // output
    var outputStatisticsData = Observable<Statistics?>(nil)
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewDidLoad.bind { [weak self] _ in
            self?.getStatistics()
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
    
}
