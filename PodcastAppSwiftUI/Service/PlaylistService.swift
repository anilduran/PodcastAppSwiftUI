//
//  PlaylistService.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 20.08.2023.
//

import Foundation
import Alamofire

protocol PlaylistServiceProtocol {
    func fetchPlaylists(completion: @escaping (Result<Array<Playlist>, Error>) -> Void)
    func fetchPodcasts(playlistId: String, completion: @escaping (Result<Array<Podcast>, Error>) -> Void)
    func fetchMyPlaylists(completion: @escaping (Result<Array<Playlist>, Error>) -> Void)
    func createPlaylist(title: String, description: String, imageUrl: String, completion: @escaping (Result<Playlist, Error>) -> Void)
    func updatePlaylist(playlistId: String, title: String?, description: String?, imageUrl: String?, completion: @escaping (Result<Playlist, Error>) -> Void)
    func deletePlaylist(playlistId: String, completion: @escaping (Result<Playlist, Error>) -> Void)
    func addPodcastToPlaylist(podcastId: String, playlistId: String, completion: @escaping (Result<Podcast, Error>) -> Void)
    func removePodcastFromPlaylist(podcastId: String, playlistId: String, completion: @escaping (Result<Podcast, Error>) -> Void)
}

struct PlaylistService: PlaylistServiceProtocol {
    func fetchMyPlaylists(completion: @escaping (Result<Array<Playlist>, Error>) -> Void) {
        guard let token = AuthTokenManager.shared.getToken() else { return }
        
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        AF.request("\(Constants.BASE_URL)/api/me/playlists", method: .get, headers: headers).response { response in
            switch response.result {
                case .success(let data):
                    if let data {
                        do {
                            let playlists = try JSONDecoder().decode(Array<Playlist>.self, from: data)
                            completion(.success(playlists))
                        } catch {
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
            
        }
    }
    
    func fetchPodcasts(playlistId: String, completion: @escaping (Result<Array<Podcast>, Error>) -> Void) {
        guard let token = AuthTokenManager.shared.getToken() else { return }
        
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        AF.request("\(Constants.BASE_URL)/api/playlists/\(playlistId)/podcasts", method: .get, headers: headers).response { response in
            
            switch response.result {
            case .success(let data):
                if let data {
                    do {
                        let podcasts = try JSONDecoder().decode(Array<Podcast>.self, from: data)
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
    

    
    func fetchPlaylists(completion: @escaping (Result<Array<Playlist>, Error>) -> Void) {
        
        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }
        
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
    
        AF.request("\(Constants.BASE_URL)/api/playlists", method: .get, headers: headers).response { response in
            switch response.result {
                case .success(let data):
                    if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            let playlists = try decoder.decode(Array<Playlist>.self, from: data)
                            completion(.success(playlists))
                            
                        } catch {
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func createPlaylist(title: String, description: String, imageUrl: String, completion: @escaping (Result<Playlist, Error>) -> Void) {

        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }
            
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        let createPlaylistDTO = CreatePlaylistDTO(title: title, description: description, imageUrl: imageUrl)
        
        AF.request("\(Constants.BASE_URL)/api/playlists", method: .post, parameters: createPlaylistDTO, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            switch response.result {
                case .success(let data):
                    if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            let playlist = try decoder.decode(Playlist.self, from: data)
                            completion(.success(playlist))
                            
                        } catch {
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func updatePlaylist(playlistId: String, title: String?, description: String?, imageUrl: String?, completion: @escaping (Result<Playlist, Error>) -> Void) {

        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }
        
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        let updatePlaylistDTO = UpdatePlaylistDTO(title: title, description: description, imageUrl: imageUrl)
        
        AF.request("\(Constants.BASE_URL)/api/playlists/\(playlistId)", method: .put, parameters: updatePlaylistDTO, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            switch response.result {
                case .success(let data):
                    if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            let playlist = try decoder.decode(Playlist.self, from: data)
                            completion(.success(playlist))
                            
                        } catch {
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func deletePlaylist(playlistId: String, completion: @escaping (Result<Playlist, Error>) -> Void) {
        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }
        
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        AF.request("\(Constants.BASE_URL)/api/playlists/\(playlistId)", method: .delete, headers: headers).response { response in
            switch response.result {
                case .success(let data):
                    if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            let playlist = try decoder.decode(Playlist.self, from: data)
                            completion(.success(playlist))
                            
                        } catch {
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func addPodcastToPlaylist(podcastId: String, playlistId: String, completion: @escaping (Result<Podcast, Error>) -> Void) {
        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }
        
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        AF.request("\(Constants.BASE_URL)/api/playlists/\(playlistId)/\(podcastId)", method: .post, headers: headers).response { response in
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
    
    func removePodcastFromPlaylist(podcastId: String, playlistId: String, completion: @escaping (Result<Podcast, Error>) -> Void) {
        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }
        
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        AF.request("\(Constants.BASE_URL)/api/playlists/\(playlistId)/\(podcastId)", method: .delete, headers: headers).response { response in
            
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
    
    
}
