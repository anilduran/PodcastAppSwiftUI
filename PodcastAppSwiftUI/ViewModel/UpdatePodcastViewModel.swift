//
//  UpdatePodcastViewModel.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 30.08.2023.
//

import Foundation
import SwiftUI

class UpdatePodcastViewModel: ObservableObject {
    private let podcastService = PodcastService()
    private let uploadService = UploadService()
    @Published var isLoading = false
    
    func updatePodcast(podcastId: String, title: String? = nil, description: String? = nil, image: UIImage, podcast: Data) {
        isLoading = true
        uploadService.uploadImage(image: image) { result in
            switch result {
                case .success(let imageUrl):
                    self.uploadService.uploadPodcast(podcast: podcast) { result in
                        switch result {
                            case .success(let podcastUrl):
                                self.podcastService.updatePodcast(podcastId: podcastId, title: title, description: description, imageUrl: imageUrl, podcastUrl: podcastUrl) { result in
                                    switch result {
                                        case .success(let podcast):
                                            print(podcast)
                                            
                                        case .failure(let error):
                                            print(error)
                                    }
                                }
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
