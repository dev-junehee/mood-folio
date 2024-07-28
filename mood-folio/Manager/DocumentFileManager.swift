//
//  FileManager+.swift
//  mood-folio
//
//  Created by junehee on 7/28/24.
//

import UIKit
import Alamofire

final class DocumentFileManager {
    
    private init() { }
    static let shared = DocumentFileManager()
    
    // 사진 저장 (URL 형식)
    func saveImageToDocument(imageURL: URL, filename: String) {
        guard let directory = getDocumentPath() else { return }
        print(directory)
        
        AF.request(imageURL).responseData { response in
            switch response.result {
            case .success(let value):
                guard let image = UIImage(data: value) else { return }
                
                let fileURL = directory.appendingPathComponent("\(filename).jpg")
                
                guard let data = image.jpegData(compressionQuality: 0.5) else { return }
                
                do {
                    try data.write(to: fileURL)
                    print("FileManager File Save Succeed")
                } catch {
                    print("FileManager File Save Error", error)
                }
                
            case .failure(let error):
                print("Image Network Failed", error)
            }
        }
    }
    
    // 사진 로드
    func loadImageToDocument(filename: String) -> UIImage? {
        guard let directory = getDocumentPath() else { return nil }
        print(directory)
        let fileURL = directory.appendingPathComponent("\(filename).jpg")

        // 이 경로에 실제 파일이 존재하는지 확인
        if #available(iOS 16.0, *) {
            if FileManager.default.fileExists(atPath: fileURL.path()) {
                return UIImage(contentsOfFile: fileURL.path())
            } else {
                return UIImage(systemName: "star.fill")
            }
        } else {
            if FileManager.default.fileExists(atPath: fileURL.path) {
                return UIImage(contentsOfFile: fileURL.path)
            } else {
                return UIImage(systemName: "star.fill")
            }
        }
    }

    // 사진 삭제
    func removeImageFromDocument(filename: String) {
        guard let directory = getDocumentPath() else { return }
        print(directory)
        let fileURL = directory.appendingPathComponent("\(filename).jpg")

        if #available(iOS 16.0, *) {
            if FileManager.default.fileExists(atPath: fileURL.path()) {
              do {
                  try FileManager.default.removeItem(atPath: fileURL.path())
              } catch {
                  print("FileManager File Remove Error", error)
              }
            } else {
              print("FileManager File No Exist")
            }
        } else {
            if FileManager.default.fileExists(atPath: fileURL.path) {
              do {
                  try FileManager.default.removeItem(atPath: fileURL.path)
              } catch {
                  print("FileManager File Remove Error", error)
              }
            } else {
              print("FileManager File No Exist")
            }
        }
    }
    
    // 경로 확인
    func getDocumentPath() -> URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
}
