//
//  UpdatePlaylistViewModel.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 30.08.2023.
//

import Foundation
import SwiftUI

class UpdatePlaylistViewModel: ObservableObject {
    
  
    private let playlistService = PlaylistService()
    private let uploadService = UploadService()
    @Published var isLoading = false
    
    func updatePlaylist(playlistId: String, title: String?, description: String?, image: UIImage) {
        isLoading = true
        uploadService.uploadImage(image: image) { result in
            switch result {
                case .success(let url):
                    self.playlistService.updatePlaylist(playlistId: playlistId, title: title, description: description, imageUrl: url) { result in
                        switch result {
                            case .success(let playlist):
                                print(playlist)
                            case .failure(let error):
                                print(error)
                        }
                    }
                case .failure(let error):
                    print(error)
            }
        }
        isLoading = false
    }
    
    
    
}
