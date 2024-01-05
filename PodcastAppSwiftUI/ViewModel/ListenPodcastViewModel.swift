//
//  ListenPodcastViewModel.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 15.06.2023.
//

import Foundation

class ListenPodcastViewModel: ObservableObject {
    
    private let podcastService = PodcastService()
    private let playlistService = PlaylistService()
    @Published var podcastComments: Array<PodcastComment> = []
    @Published var playlists: Array<Playlist> = []
    
    func fetchPlaylists() {
        playlistService.fetchMyPlaylists { [unowned self] result in
            switch result {
            case .success(let playlists):
                self.playlists = playlists
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func addPodcastToPlaylist(playlistId: String, podcastId: String) {
        
        playlistService.addPodcastToPlaylist(podcastId: podcastId, playlistId: playlistId) { result in
            switch result {
                case .success(let podcast):
                    print(podcast)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func removePodcastFromPlaylist(playlistId: String, podcastId: String) {
        playlistService.removePodcastFromPlaylist(podcastId: podcastId, playlistId: playlistId) { result in
            switch result {
                case .success(let podcast):
                    print(podcast)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func likePodcast(podcastId: String) {
        podcastService.likePodcast(podcastId: podcastId) {  result in
            switch result {
                case .success(let podcast):
                    print(podcast)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func unlikePodcast(podcastId: String) {
        podcastService.unlikePodcast(podcastId: podcastId) { result in
            switch result {
                case .success(let podcast):
                    print(podcast)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func fetchComments(podcastId: String) {
        podcastService.fetchComments(podcastId: podcastId) { [unowned self] result in
            switch result {
                case .success(let podcastComments):
                    self.podcastComments = podcastComments
                case .failure(let error):
                    print(error)
            }
            
        }
    }
    
    func createComment(podcastId: String, content: String) {
        podcastService.createComment(podcastId: podcastId, content: content) { [unowned self] result in
            switch result {
                case .success(let podcastComment):
                    self.podcastComments.append(podcastComment)
                case .failure(let error):
                    print(error)
            }
            
        }
    }
    
    func updateComment(podcastId: String, commentId: String, content: String?) {
        podcastService.updateComment(podcastId: podcastId, podcastCommentId: commentId, content: content) { result in
            switch result {
                case .success(let podcastComment):
                    print(podcastComment)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func deleteComment(podcastId: String, commentId: String) {
        podcastService.deleteComment(podcastId: podcastId, podcastCommentId: commentId) { result in
            switch result {
                case .success(let podcastComment):
                    print(podcastComment)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    
}
