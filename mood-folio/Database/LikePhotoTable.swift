//
//  LikePhotoTable.swift
//  mood-folio
//
//  Created by junehee on 7/27/24.
//

import Foundation
import RealmSwift

class LikePhoto: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var regData: Date    // 사용자가 사진을 찜한 날짜
    @Persisted var createAt: Date?  // API 응답데이터 값
    @Persisted var width: Int
    @Persisted var height: Int
    @Persisted var urlRaw: String
    @Persisted var urlSmall: String
    @Persisted var likes: Int
    @Persisted var userName: String
    @Persisted var userProfileImage: String
    
    convenience init(photo: Photo) {
        self.init()
        self.id = photo.id
        self.regData = Date()
        self.createAt = photo.create_at
        self.width = photo.width
        self.height = photo.height
        self.urlRaw = photo.urls.raw
        self.urlSmall = photo.urls.small
        self.likes = photo.likes
        self.userName = photo.user.name
        self.userProfileImage = photo.user.profile_image.medium
    }
}
