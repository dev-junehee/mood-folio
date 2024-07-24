//
//  TopicViewModel.swift
//  mood-folio
//
//  Created by junehee on 7/24/24.
//

import Foundation

final class TopicViewModel {
    
    // input
    var inputViewDidLoad = Observable<Void?>(nil)
    
    // output
    var outputProfileImage = Observable<Int>(UserDefaultsManager.shared.profile)
    var outputCallRequestNotify = Observable<Void?>(nil)
    var outputTopicList = Observable<[[Topic]]>([[], [], []])
    
    init() {
        transform()
    }
    
    private func transform() {
        inputViewDidLoad.bind { [weak self] _ in
            self?.outputProfileImage.value = UserDefaultsManager.shared.profile
            self?.getTopics()
        }
    }
    
    private func getTopics() {
        let group = DispatchGroup()
        
        // 골든 아워
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.callRequest(api: .topic(topicId: "golden-hour")) { (res: Result<[Topic]?, Error>) in
                switch res {
                case .success(let data):
                    guard let data else { return }
                    self.outputTopicList.value[0] = data
                case .failure(let error):
                    print(error)
                }
                group.leave()
            }
        }
        
        // 비즈니스 및 업무
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.callRequest(api: .topic(topicId: "business-work")) { (res: Result<[Topic]?, Error>) in
                switch res {
                case .success(let data):
                    guard let data else { return }
                    self.outputTopicList.value[1] = data
                case .failure(let error):
                    print(error)
                }
                group.leave()
            }
        }
        
        // 건축 및 인테리어
        group.enter()
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.callRequest(api: .topic(topicId: "architecture-interior")) { (res: Result<[Topic]?, Error>) in
                switch res {
                case .success(let data):
                    guard let data else { return }
                    self.outputTopicList.value[2] = data
                case .failure(let error):
                    print(error)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.outputCallRequestNotify.value = ()
        }
    }
    
}
