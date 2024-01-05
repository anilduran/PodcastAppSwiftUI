//
//  CreatePlaylistViewModel.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 22.08.2023.
//

import Foundation
import SwiftUI

class CreatePlaylistViewModel: ObservableObject {
    
    @Published var playlist: Playlist?
    private let playlistService = PlaylistService()
    private let uploadService = UploadService()
    @Published var errorString: String?
    @Published var isLoading = false
    
    func createPlaylist(title: String, description: String, image: UIImage) {
        isLoading = true
        uploadService.uploadImage(image: image) { [unowned self] result in
            switch result {
                case .success(let url):
                    self.playlistService.createPlaylist(title: title, description: description, imageUrl: url) { result in
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
