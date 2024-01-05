//
//  PodcastService.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 20.08.2023.
//

import Foundation
import Alamofire
protocol PodcastServiceProtocol {
    func fetchPodcasts(completion: @escaping (Result<Array<Podcast>, Error>) -> Void)
    func createPodcast(podcastListId: String, title: String, description: String, imageUrl: String, podcastUrl: String, completion: @escaping (Result<Podcast, Error>) -> Void)
    func updatePodcast(podcastId: String, title: String?, description: String?, imageUrl: String?, podcastUrl: String?, completion: @escaping (Result<Podcast, Error>) -> Void)
    func deletePodcast(podcastId: String, completion: @escaping (Result<Podcast, Error>) -> Void)
    func fetchLikedPodcasts(completion: @escaping (Result<Array<Podcast>, Error>) -> Void)
    func likePodcast(podcastId: String, completion: @escaping (Result<Podcast, Error>) -> Void)
    func unlikePodcast(podcastId: String, completion: @escaping (Result<Podcast, Error>) -> Void)
    func fetchComments(podcastId: String, completion: @escaping (Result<Array<PodcastComment>, Error>) -> Void)
    func createComment(podcastId: String, content: String, completion: @escaping (Result<PodcastComment, Error>) -> Void)
    func updateComment(podcastId: String, podcastCommentId: String, content: String?, completion: @escaping (Result<PodcastComment, Error>) -> Void)
    func deleteComment(podcastId: String, podcastCommentId: String, completion: @escaping (Result<PodcastComment, Error>) -> Void)
}

struct PodcastService: PodcastServiceProtocol {
    
    
    func fetchPodcasts(completion: @escaping (Result<Array<Podcast>, Error>) -> Void) -> Void {
     
        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }
        
        
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        AF.request("\(Constants.BASE_URL)/api/podcasts", method: .get, headers: headers).response { response in

            switch response.result {
                
            case .success(let data):
                
                if let data = data {
                    do {
                        
                        let decoder = JSONDecoder()
                        let podcasts = try decoder.decode(Array<Podcast>.self, from: data)
                        completion(.success(podcasts))
                        
                    } catch {
                        completion(.failure(error))
                    }
                    
                }
                
            case .failure(let error):
                completion(.failure(error))
                
            }
            
        }
        
    }
    
    func createPodcast(podcastListId: String, title: String, description: String, imageUrl: String, podcastUrl: String, completion: @escaping (Result<Podcast, Error>) -> Void) -> Void {
        
        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }

        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        let createPodcastDTO = CreatePodcastDTO(title: title, description: description, imageUrl: imageUrl, podcastUrl: podcastUrl, isVisible: false, podcastListId: podcastListId)
        
        AF.request("\(Constants.BASE_URL)/api/podcasts", method: .post, parameters: createPodcastDTO, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            switch response.result {
                case .success(let data):
                    if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            let podcast = try decoder.decode(Podcast.self, from: data)
                            completion(.success(podcast))
                            
                        } catch {
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
        
    }
    
    func updatePodcast(podcastId: String, title: String?, description: String?, imageUrl: String?, podcastUrl: String?, completion: @escaping (Result<Podcast, Error>) -> Void) -> Void {
        
        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }
        
        
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        let createPodcastDTO = UpdatePodcastDTO(title: title, description: description, imageUrl: imageUrl, podcastUrl: podcastUrl)
        
        AF.request("\(Constants.BASE_URL)/api/podcasts/\(podcastId)", method: .put, parameters: createPodcastDTO, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            switch response.result {
                case .success(let data):
                    if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            let podcast = try decoder.decode(Podcast.self, from: data)
                            completion(.success(podcast))
                            
                        } catch {
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
        
    }
    
    func deletePodcast(podcastId: String, completion: @escaping (Result<Podcast, Error>) -> Void) -> Void {

        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }
        
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        AF.request("\(Constants.BASE_URL)/api/podcast-lists/\(podcastId)", method: .delete, headers: headers).response { response in
            switch response.result {
                case .success(let data):
                    if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            let podcast = try decoder.decode(Podcast.self, from: data)
                            completion(.success(podcast))
                        } catch {
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func fetchLikedPodcasts(completion: @escaping (Result<Array<Podcast>, Error>) -> Void) {
        
        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }
        
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        AF.request("\(Constants.BASE_URL)/api/me/liked-podcasts", method: .get, headers: headers).response { response in
            switch response.result {
                case .success(let data):
                    if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            let podcasts = try decoder.decode(Array<Podcast>.self, from: data)
                            completion(.success(podcasts))
                            
                        } catch {
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func likePodcast(podcastId: String, completion: @escaping (Result<Podcast, Error>) -> Void) {

        
        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }

        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        AF.request("\(Constants.BASE_URL)/api/podcasts/\(podcastId)/like", method: .post, headers: headers).response { response in
            switch response.result {
                case .success(let data):
                    if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            let podcast = try decoder.decode(Podcast.self, from: data)
                            completion(.success(podcast))
                            
                        } catch {
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func unlikePodcast(podcastId: String, completion: @escaping (Result<Podcast, Error>) -> Void) {
        
        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }

        
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        AF.request("\(Constants.BASE_URL)/api/podcasts/\(podcastId)/unlike", method: .delete, headers: headers).response { response in
            switch response.result {
                case .success(let data):
                    if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            let podcast = try decoder.decode(Podcast.self, from: data)
                            completion(.success(podcast))
                            
                        } catch {
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func fetchComments(podcastId: String, completion: @escaping (Result<Array<PodcastComment>, Error>) -> Void) {
        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }
        
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        AF.request("\(Constants.BASE_URL)/api/podcasts/\(podcastId)/comments", method: .get, headers: headers).response { response in
            switch response.result {
                case .success(let data):
                    if let data {
                        do {
                            let podcasts = try JSONDecoder().decode(Array<PodcastComment>.self, from: data)
                            completion(.success(podcasts))
                        } catch {
                            completion(.failure(error))
                        }
                    }
                    
                    
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func createComment(podcastId: String, content: String, completion: @escaping (Result<PodcastComment, Error>) -> Void) {
        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }
        
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        let createPodcastCommentDTO = CreatePodcastCommentDTO(content: content)
        
        AF.request("\(Constants.BASE_URL)/api/podcasts/\(podcastId)/comments", method: .post, parameters: createPodcastCommentDTO, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            
            switch response.result {
            case .success(let data):
                if let data {
                    do {
                        let podcastComment = try JSONDecoder().decode(PodcastComment.self, from: data)
                        completion(.success(podcastComment))
                    } catch {
                        completion(.failure(error))
                    }
                }
                
            case .failure(let error):
                completion(.failure(error))
                
            }
            
        }
        
    }
    
    func updateComment(podcastId: String, podcastCommentId: String, content: String?, completion: @escaping (Result<PodcastComment, Error>) -> Void) {
        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }
        
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        let updatePodcastCommentDTO = UpdatePodcastCommentDTO(content: content)
        
        AF.request("\(Constants.BASE_URL)/api/podcasts/\(podcastId)/comments/\(podcastCommentId)", method: .put, parameters: updatePodcastCommentDTO, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            switch response.result {
                case .success(let data):
                    if let data {
                        do {
                            let podcastComment = try JSONDecoder().decode(PodcastComment.self, from: data)
                            completion(.success(podcastComment))
                        } catch {
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func deleteComment(podcastId: String, podcastCommentId: String, completion: @escaping (Result<PodcastComment, Error>) -> Void) {
        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }
        
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        AF.request("\(Constants.BASE_URL)/api/podcasts/\(podcastId)/comments/\(podcastCommentId)", method: .delete, headers: headers).response { response in
            switch response.result {
                case .success(let data):
                    if let data {
                        do {
                            let podcastComment = try JSONDecoder().decode(PodcastComment.self, from: data)
                            completion(.success(podcastComment))
                        } catch {
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }

}
