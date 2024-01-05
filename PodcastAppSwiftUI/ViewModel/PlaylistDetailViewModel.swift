//
//  PlaylistDetailViewModel.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 15.06.2023.
//

import Foundation

class PlaylistDetailViewModel: ObservableObject {
    
   
    private var playlistService = PlaylistService()
    @Published var errorString: String?
    @Published var podcasts: Array<Podcast> = []
    
    func fetchPodcasts(playlistId: String) {
        playlistService.fetchPodcasts(playlistId: playlistId) { [unowned self] result in
            switch result {
                case .success(let podcasts):
                    self.podcasts = podcasts
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
    
    
}
