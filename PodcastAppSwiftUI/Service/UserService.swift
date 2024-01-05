//
//  UserService.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 29.10.2023.
//

import Foundation
import Alamofire

protocol UserServiceProtocol {
    
    func fetchCurrentUser(completion: @escaping (Result<User, Error>) -> Void)

    func updateUser(userId: String, username: String?, email: String?, password: String?, profilePhotoUrl: String?, completion: @escaping (Result<User, Error>) -> Void)
    
    func fetchPodcastLists(userId: String, completion: @escaping (Result<Array<PodcastList>, Error>) -> Void)
    
    
}

struct UserService: UserServiceProtocol {
    
    func fetchCurrentUser(completion: @escaping (Result<User, Error>) -> Void) {
        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }
        
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        AF.request("\(Constants.BASE_URL)/api/me", method: .get, headers: headers).response { response in
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
    
    func updateUser(userId: String, username: String? = nil, email: String? = nil, password: String? = nil, profilePhotoUrl: String? = nil, completion: @escaping (Result<User, Error>) -> Void) {
        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }
        
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]

        let updateUserDTO = UpdateUserDTO(username: username, email: email, password: password, profilePhotoUrl: profilePhotoUrl)
        
        AF.request("\(Constants.BASE_URL)/api/me", method: .put, parameters: updateUserDTO, encoder: JSONParameterEncoder.default, headers: headers).response { response in
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
    
    func fetchPodcastLists(userId: String, completion: @escaping (Result<Array<PodcastList>, Error>) -> Void) {
        
        guard let token = AuthTokenManager.shared.getToken() else { return }
        
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        AF.request("\(Constants.BASE_URL)/api/users/\(userId)/podcast-lists", method: .get, headers: headers).response { response in
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
    
}
