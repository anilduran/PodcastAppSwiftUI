//
//  PlaylistsViewModel.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 15.06.2023.
//

import Foundation

class PlaylistsViewModel: ObservableObject {
    
    @Published var playlists: Array<Playlist> = []
    private var playlistService = PlaylistService()
    @Published var errorString: String?
    
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
    
    
}
