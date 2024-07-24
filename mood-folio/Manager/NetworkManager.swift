//
//  NetworkManager.swift
//  mood-folio
//
//  Created by junehee on 7/24/24.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    private init() { }
    static let shared = NetworkManager()
    
    func callRequest<T: Decodable>(api: API_CASE, completion: @escaping (Result<T?, Error>) -> Void) {
        print("API 확인 ===", api.endPoint)
        AF.request(api.endPoint, 
                   method: api.method, 
                   parameters: api.params, 
                   encoding: URLEncoding.queryString)
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                print("API 호출 성공")
                completion(.success(value))
            case .failure(let error):
                print("API 호출 실패")
                completion(.failure(error))
            }
        }
    }
    
}
