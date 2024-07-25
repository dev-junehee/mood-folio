//
//  Topic.swift
//  mood-folio
//
//  Created by junehee on 7/24/24.
//

import Foundation

struct Topic: Decodable {
    let id: String
    let create_at: Date? // String?
    let width: Int
    let height: Int
    let urls: TopicURLs
    let likes: Int
    let user: TopicUser
}

struct TopicURLs: Decodable {
    let raw: String
    let small: String
}

struct TopicUser: Decodable {
    let name: String
    let profile_image: TopicUserProfileImage
}

struct TopicUserProfileImage: Decodable {
    let medium: String
}
