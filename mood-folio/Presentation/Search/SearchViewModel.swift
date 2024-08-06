//
//  SearchViewModel.swift
//  mood-folio
//
//  Created by junehee on 7/25/24.
//

import Foundation

enum SearchResult {
    case empty
}

final class SearchViewModel {
    
    private let repo = LikePhotoRepository()
    
    // input
    var inputSearchText = Observable<String?>(nil)
    var inputSortButton = Observable<SearchOrder>(.relevant)    // 검색 결과 정렬
    var inputInfinityScroll = Observable<Void?>(nil)
    var inputHeartButton = Observable<Photo?>(nil)
    
    // output
    var outputSearchResult = Observable<Search>(Search(total: 0, total_pages: 0, results: []))
    
    
    var outputSearchNoResult = Observable<Void?>(nil)
    var outputCreateLikePhotoTrigger = Observable<Void?>(nil)
    var outputDeleteLikePhotoTrigger = Observable<Void?>(nil)
    
    // 검색 결과 데이터 페이지
    private var page = 1
    
    init() {
        transform()
    }
    
    private func transform() {
        inputSearchText.bind { [weak self] _ in
            self?.page = 1
            self?.getSearch()
        }
        
        inputSortButton.bind { [weak self] _ in
            self?.getSearch()
        }
        
        inputInfinityScroll.bind { [weak self] _ in
            // 요청 페이지와 총 페이지가 같으면 추가 요청을 하지 않도록 처리
            if self?.page == self?.outputSearchResult.value.total_pages { return }
            self?.page += 1
            self?.getSearch()
        }
        
        inputHeartButton.bind { [weak self] photo in
            guard let photo else { return }
            let isLikePhoto = self?.repo.isLikePhoto(id: photo.id)
            
            if isLikePhoto != true {
                self?.createLikePhoto(photo)
            } else {
                guard let likePhoto = self?.repo.getLikePhoto(id: photo.id)  else { return }
                self?.deleteLikePhoto(likePhoto)
            }
            
        }
    }
    
    private func getSearch() {
        guard let query = self.inputSearchText.value else { return }
        let order = self.inputSortButton.value
        print("query: ", query)
        print("order: ", order.rawValue)
        
        NetworkManager.shared.callRequest(api: .search(query: query, page: self.page, order: order)) { (res: Result<Search?, Error>) in
            switch res {
            case .success(let data):
                guard let data else { return }
                
                if data.total == 0 {
                    self.outputSearchNoResult.value = ()
                    return
                }
                
                // 페이지가 1일 때는 기존 데이터 제거
                if self.page == 1 {
                    self.outputSearchResult.value = data
                } else {
                    self.outputSearchResult.value.results.append(contentsOf: data.results)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func createLikePhoto(_ data: Photo) {
        let likePhoto = LikePhoto(photo: data)
        self.repo.createLikePhoto(likePhoto)
        
        guard let url = URL(string: likePhoto.urlRaw) else { return }
        DocumentFileManager.shared.saveImageToDocument(imageURL: url, filename: likePhoto.id)
        
        self.outputCreateLikePhotoTrigger.value = ()
    }
    
    private func deleteLikePhoto(_ data: LikePhoto) {
        DocumentFileManager.shared.removeImageFromDocument(filename: data.id)
        self.repo.deleteLikePhoto(photo: data)
        self.outputDeleteLikePhotoTrigger.value = ()
    }
    
}
