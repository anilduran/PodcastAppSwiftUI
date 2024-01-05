//
//  PodcastListService.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 20.08.2023.
//

import Foundation
import Alamofire



protocol PodcastListServiceProtocol {
    func fetchPodcastLists(completion: @escaping (Result<Array<PodcastList>, Error>) -> Void)
    func fetchMyPodcastLists(completion: @escaping (Result<Array<PodcastList>, Error>) -> Void)
    func fetchFollowingPodcastLists(completion: @escaping (Result<Array<PodcastList>, Error>) -> Void)
    func fetchCreator(podcastListId: String, completion: @escaping (Result<User, Error>) -> Void)
    func createPodcastList(title: String, description: String, imageUrl: String, completion: @escaping (Result<PodcastList, Error>) -> Void)
    func updatePodcastList(podcastListId: String, title: String?, description: String?, imageUrl: String?, completion: @escaping (Result<PodcastList, Error>) -> Void)
    func deletePodcastList(podcastListId: String, completion: @escaping (Result<PodcastList, Error>) -> Void)
    func search(text: String, completion: @escaping (Result<Array<PodcastList>, Error>) -> Void)
    func followPodcastList(podcastListId: String, completion: @escaping (Result<PodcastList, Error>) -> Void)
    func unfollowPodcastList(podcastListId: String, completion: @escaping (Result<PodcastList, Error>) -> Void)
    func fetchPodcasts(podcastListId: String, completion: @escaping (Result<Array<Podcast>, Error>) -> Void)
    func fetchComments(podcastListId: String, completion: @escaping (Result<Array<PodcastListComment>, Error>) -> Void)
    func createComment(podcastListId: String, content: String, completion: @escaping (Result<PodcastListComment, Error>) -> Void)
    func updateComment(podcastListId: String, commentId: String, content: String?, completion: @escaping (Result<PodcastListComment, Error>) -> Void)
    func deleteComment(podcastListId: String, commentId: String, completion: @escaping (Result<PodcastListComment, Error>) -> Void)
}

struct PodcastListService: PodcastListServiceProtocol {
    func fetchCreator(podcastListId: String, completion: @escaping (Result<User, Error>) -> Void) {
        guard let token = AuthTokenManager.shared.getToken() else { return }
        
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        AF.request("\(Constants.BASE_URL)/api/podcast-lists/\(podcastListId)/creator", method: .get, headers: headers).response { response in
            switch response.result {
            case .success(let data):
                if let data {
                    do {
                        let user = try JSONDecoder().decode(User.self, from: data)
                        completion(.success(user))
                    } catch {
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
        
        
    }
    
    
    func fetchPodcasts(podcastListId: String, completion: @escaping (Result<Array<Podcast>, Error>) -> Void) {
        
        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }
        
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        AF.request("\(Constants.BASE_URL)/api/podcast-lists/\(podcastListId)/podcasts", method: .get, headers: headers).response { response in
            switch response.result {
                case .success(let data):
                    if let data {
                        do {
                            let podcastLists = try JSONDecoder().decode(Array<Podcast>.self, from: data)
                            completion(.success(podcastLists))
                        } catch {
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    
    func fetchPodcastLists(completion: @escaping (Result<Array<PodcastList>, Error>) -> Void) -> Void {
        
        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }
        
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        AF.request("\(Constants.BASE_URL)/api/podcast-lists", method: .get, headers: headers).response { response in
            switch response.result {
                case .success(let data) :
                    
                    
                    if let data = data {
                        do {
                             
                            let decoder = JSONDecoder()
                            let podcastLists = try decoder.decode(Array<PodcastList>.self, from: data)
                            completion(.success(podcastLists))
                            
                        } catch {
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func fetchMyPodcastLists(completion: @escaping (Result<Array<PodcastList>, Error>) -> Void) {
        
        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }

        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        AF.request("\(Constants.BASE_URL)/api/me/podcast-lists", method: .get, headers: headers).response { response in
            switch response.result {
                case .success(let data):
                    if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            let podcastLists = try decoder.decode(Array<PodcastList>.self, from: data)
                            completion(.success(podcastLists))
                        } catch {
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func fetchFollowingPodcastLists(completion: @escaping (Result<Array<PodcastList>, Error>) -> Void) {
        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }
        
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        AF.request("\(Constants.BASE_URL)/api/me/following", method: .get, headers: headers).response { response in
            switch response.result {
                case .success(let data):
                    
                    if let data {
                        do {
                            let podcastLists = try JSONDecoder().decode(Array<PodcastList>.self, from: data)
                            completion(.success(podcastLists))
                        } catch {
                            completion(.failure(error))
                        }
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func createPodcastList(title: String, description: String, imageUrl: String, completion: @escaping (Result<PodcastList, Error>) -> Void) -> Void {
        
        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }
        
        let createPodcastListDTO = CreatePodcastListDTO(title: title, description: description, imageUrl: imageUrl)
        
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        AF.request("\(Constants.BASE_URL)/api/podcast-lists", method: .post, parameters: createPodcastListDTO, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            switch response.result {
                case .success(let data):
                    if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            let podcastList = try decoder.decode(PodcastList.self, from: data)
                            completion(.success(podcastList))
                            
                        } catch {
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
                
            }
        }
    }
    
    func updatePodcastList(podcastListId: String, title: String?, description: String?, imageUrl: String?, completion: @escaping (Result<PodcastList, Error>) -> Void) -> Void {
        
        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }
        
        let updatePodcastListDTO = UpdatePodcastListDTO(title: title, description: description, imageUrl: imageUrl)
        
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        AF.request("\(Constants.BASE_URL)/api/podcast-lists/\(podcastListId)", method: .put, parameters: updatePodcastListDTO, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            switch response.result {
                case .success(let data):
                    if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            let podcastList = try decoder.decode(PodcastList.self, from: data)
                            completion(.success(podcastList))
                        } catch {
                            completion(.failure(error))
                        }
                    }
    
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func deletePodcastList(podcastListId: String, completion: @escaping (Result<PodcastList, Error>) -> Void) -> Void {
        
        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }
        
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        AF.request("\(Constants.BASE_URL)/api/podcast-lists/\(podcastListId)", method: .delete, headers: headers).response { response in
            switch response.result {
                case .success(let data):
                    if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            let podcastList = try decoder.decode(PodcastList.self, from: data)
                            completion(.success(podcastList))
                        } catch {
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
            
        }
        
    }
    
    func search(text: String, completion: @escaping (Result<Array<PodcastList>, Error>) -> Void) -> Void {
        
        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }
            
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        AF.request("\(Constants.BASE_URL)/api/podcast-lists?search=\(text)", method: .get, headers: headers).response { response in
            switch response.result {
                case .success(let data):           
                    if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            let podcastLists = try decoder.decode(Array<PodcastList>.self, from: data)
                            completion(.success(podcastLists))
                            
                        } catch {
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    
    func followPodcastList(podcastListId: String, completion: @escaping (Result<PodcastList, Error>) -> Void) {

        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }
        
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        AF.request("\(Constants.BASE_URL)/api/podcast-lists/\(podcastListId)/follow", method: .post, headers: headers).response { response in
            switch response.result {
                case .success(let data):
                    if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            let podcastList = try decoder.decode(PodcastList.self, from: data)
                            completion(.success(podcastList))
                        } catch {
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
        
    }
    
    func unfollowPodcastList(podcastListId: String, completion: @escaping (Result<PodcastList, Error>) -> Void) {
        
        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }
            
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]

        AF.request("\(Constants.BASE_URL)/api/podcast-lists/\(podcastListId)/unfollow", method: .delete, headers: headers).response { response in
            switch response.result {
                case .success(let data):
                    if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            let podcastList = try decoder.decode(PodcastList.self, from: data)
                            completion(.success(podcastList))
                        } catch {
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func fetchComments(podcastListId: String, completion: @escaping (Result<Array<PodcastListComment>, Error>) -> Void) {
        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }
        
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        AF.request("\(Constants.BASE_URL)/api/podcast-lists/\(podcastListId)/comments", method: .get, headers: headers).response { response in
            switch response.result {
            case .success(let data):
                if let data {
                    do {
                        let podcastListComments = try JSONDecoder().decode(Array<PodcastListComment>.self, from: data)
                        completion(.success(podcastListComments))
                    } catch {
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
    
    func createComment(podcastListId: String, content: String, completion: @escaping (Result<PodcastListComment, Error>) -> Void) {
        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }
        
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        let createPodcastListCommentDTO = CreatePodcastListCommentDTO(content: content)
        
        AF.request("\(Constants.BASE_URL)/api/podcast-lists/\(podcastListId)/comments", method: .post, parameters: createPodcastListCommentDTO, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            switch response.result {
                case .success(let data):
                    if let data {
                        
                        do {
                            let podcastListComment = try JSONDecoder().decode(PodcastListComment.self, from: data)
                            completion(.success(podcastListComment))
                            
                        } catch {
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func updateComment(podcastListId: String, commentId: String, content: String?, completion: @escaping (Result<PodcastListComment, Error>) -> Void) {
        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }
        
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        let updatePodcastListCommentDTO = UpdatePodcastListCommentDTO(content: content)
        
        AF.request("\(Constants.BASE_URL)/api/podcast-lists/\(podcastListId)/comments/\(commentId)", method: .put, parameters: updatePodcastListCommentDTO, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            switch response.result {
                case .success(let data):
                    if let data {
                        do {
                            let podcastListComment = try JSONDecoder().decode(PodcastListComment.self, from: data)
                            completion(.success(podcastListComment))
                        } catch {
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func deleteComment(podcastListId: String, commentId: String, completion: @escaping (Result<PodcastListComment, Error>) -> Void) {
        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }
        
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        AF.request("\(Constants.BASE_URL)/api/podcast-lists/\(podcastListId)/comments/\(commentId)", method: .delete, headers: headers).response { response in
            switch response.result {
                case .success(let data):
                    if let data {
                        do {
                            let podcastListComment = try JSONDecoder().decode(PodcastListComment.self, from: data)
                            completion(.success(podcastListComment))
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
