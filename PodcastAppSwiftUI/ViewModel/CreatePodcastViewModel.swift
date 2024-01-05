//
//  CreatePodcastViewModel.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 22.08.2023.
//

import Foundation
import SwiftUI

class CreatePodcastViewModel: ObservableObject {
    
    private var uploadService = UploadService()
    private var podcastService = PodcastService()
    
    @Published var podcast: Podcast?
    @Published var isLoading = false
    
    func createPodcast(podcastListId: String, title: String, description: String, podcast: Data, image: UIImage) {
        isLoading = true
        self.uploadService.uploadPodcast(podcast: podcast) { [unowned self] result in
            switch result {
                case .success(let podcastUrl):
                    
                    self.uploadService.uploadImage(image: image) { [unowned self] result in
                        switch result {
                            case .success(let imageUrl):
                                self.podcastService.createPodcast(podcastListId: podcastListId, title: title, description: description, imageUrl: imageUrl, podcastUrl: podcastUrl) { result in
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
