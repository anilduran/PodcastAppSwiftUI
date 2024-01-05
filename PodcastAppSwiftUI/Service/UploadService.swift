//
//  UploadService.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 29.08.2023.
//

import Foundation
import Alamofire

protocol UploadServiceProtocol {
    func getPresignedURLForImage(completion: @escaping (Result<GetImagePresignedURLResponse, Error>) -> Void)
    func getPresignedURLForPodcast(completion: @escaping (Result<GetPodcastPresignedURLResponse, Error>) -> Void)
    func uploadImage(image: UIImage, completion: @escaping (Result<String, Error>) -> Void)
    func uploadPodcast(podcast: Data, completion: @escaping (Result<String, Error>) -> Void)
}

struct UploadService: UploadServiceProtocol {
    func getPresignedURLForImage(completion: @escaping (Result<GetImagePresignedURLResponse, Error>) -> Void) {
            
        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }
        
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        AF.request("\(Constants.BASE_URL)/api/podcast-lists/image-presigned-url", method: .get, headers: headers).response { response in
            
            switch response.result {
                case .success(let data):
                    if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            let getImagePresignedURLResponse = try decoder.decode(GetImagePresignedURLResponse.self, from: data)
                            completion(.success(getImagePresignedURLResponse))
                            
                        } catch {
                            completion(.failure(error))
                            
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func getPresignedURLForPodcast(completion: @escaping (Result<GetPodcastPresignedURLResponse, Error>) -> Void) {
        
        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }
            
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        AF.request("\(Constants.BASE_URL)/api/podcast-lists/podcast-presigned-url", method: .get, headers: headers).response { response in
            switch response.result {
                case .success(let data):
                    if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            let getPodcastPresignedURLResponse = try decoder.decode(GetPodcastPresignedURLResponse.self, from: data)
                            completion(.success(getPodcastPresignedURLResponse))
                        } catch {
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    
    func uploadImage(image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        getPresignedURLForImage { result in
            switch result {
                
                case .success(let getImagePresignedURLResponse):

                    let imageData = image.jpegData(compressionQuality: 0.50)!
                    
                    let headers: HTTPHeaders = [
                        "Content-Length": "\(imageData.count)",
                        "Content-Type": "image/jpeg"
                    ]
                    
                    AF.upload(imageData, to: getImagePresignedURLResponse.url, method: .put, headers: headers).response { response in
                        switch response.result {
                            case .success(_):
                                completion(.success(getImagePresignedURLResponse.key))
                            case .failure(let error):
                                completion(.failure(error))
                        }
                        
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    
    func uploadPodcast(podcast: Data, completion: @escaping (Result<String, Error>) -> Void) {
        getPresignedURLForPodcast { result in
            
            switch result {
                    
                case .success(let getPresignedURLForPodcast):
                    
                    let headers: HTTPHeaders = [
                        "Content-Type": "audio/mp3",
                        "Content-Length": "\(podcast.count)"
                    ]
                    
                    AF.upload(podcast, to: getPresignedURLForPodcast.url, method: .put, headers: headers).response { response in
                        switch response.result {
                            case .success(_):
                                completion(.success(getPresignedURLForPodcast.key))
                            case .failure(let error):
                                completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
                
            }

        }
    }
    
}

/*AF.upload(multipartFormData: { multipartFormData in
    multipartFormData.append(imageData, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")

}, to: url, method: .put).response { response in
    print(response.response?.statusCode)
    
    
}
.uploadProgress { progress in

    
}*/
