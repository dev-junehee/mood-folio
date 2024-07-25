//
//  Topic.swift
//  mood-folio
//
//  Created by junehee on 7/24/24.
//

import Foundation

struct Photo: Decodable, Hashable {
    let id: String
    let create_at: Date? // String?
    let width: Int
    let height: Int
    let urls: PhotoURL
    let likes: Int
    let user: PhotoUser
}

struct PhotoURL: Decodable, Hashable {
    let raw: String
    let small: String
}

struct PhotoUser: Decodable, Hashable {
    let name: String
    let profile_image: PhotoUserProfileImage
}

struct PhotoUserProfileImage: Decodable, Hashable {
    let medium: String
}
