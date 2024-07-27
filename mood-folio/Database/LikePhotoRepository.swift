//
//  LikePhotoRepository.swift
//  mood-folio
//
//  Created by junehee on 7/27/24.
//

import Foundation
import RealmSwift

final class LikePhotoRepository {
    
    private let realm = try! Realm()
    
    // 사진 찜하기
    func createLikePhoto(_ photo: LikePhoto) {
        do {
            try realm.write {
                realm.add(photo)
                print("Succeed Create LikePhoto")
                getFileURL()
            }
        } catch {
            print("Failed Create LikePhoto", error)
        }
    }
    
    // 찜한 사진 전체 불러오기
    func getAllLikePhoto() -> Results<LikePhoto> {
        return realm.objects(LikePhoto.self)
    }
    
    // 찜한 사진 불러오기 (단일)
    func getLikePhoto(id: String) -> LikePhoto? {
        return realm.object(ofType: LikePhoto.self, forPrimaryKey: id)
    }
    
    // 찜한 사진 여부 판별하기
    func isLikePhoto(id: String) -> Bool {
        if getLikePhoto(id: id) != nil {
            return true
        } else {
            return false
        }
    }
    
    // 찜한 사진 삭제하기
    func deleteLikePhoto(photo: LikePhoto) {
        do {
            try realm.write {
                realm.delete(photo)
                print("Succeed Delete LikePhoto")
            }
        } catch {
            print("Failed Delete LikePhoto", error)
        }
    }
    
    // 전체 삭제
    func deleteAllRealm() {
        do {
            try realm.write {
                realm.deleteAll()
                print("Succeed Delete All Realm Data")
            }
        } catch {
            print("Failed Delete All Realm Data", error)
        }
    }
    
    // 스키마버전 확인
    func getSchemaVersion() {
        print(realm.configuration.schemaVersion)
    }
    
    // 저장 경로 확인
    func getFileURL() {
        print(realm.configuration.fileURL ?? "No fileURL")
        
    }
    
    
}
