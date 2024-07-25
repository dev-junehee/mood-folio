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
    
    // input
    var inputSearchText = Observable<String?>(nil)
    var inputSortButton = Observable<SearchOrder>(.relevant)    // 검색 결과 정렬
    
    // output
    var outputSearchResult = Observable<Search?>(Search(total: 0, total_pages: 0, results: []))
    var outputSearchNoResult = Observable<Void?>(nil)
    
    
    init() {
        transform()
    }
    
    private func transform() {
        inputSearchText.bind { [weak self] _ in
            self?.getSearch()
        }
        
        inputSortButton.bind { [weak self] _ in
            self?.getSearch()
        }
    }
    
    private func getSearch() {
        guard let query = self.inputSearchText.value else { return }
        let order = self.inputSortButton.value
        print("query: ", query)
        print("order: ", order.rawValue)
        
        NetworkManager.shared.callRequest(api: .search(query: query, order: order)) { (res: Result<Search?, Error>) in
            switch res {
            case .success(let data):
                guard let data else { return }
                if data.total == 0 {
                    self.outputSearchNoResult.value = ()
                } else {
                    self.outputSearchResult.value = data
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
