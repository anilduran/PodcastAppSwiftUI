//
//  UpdatePodcastListViewModel.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 30.08.2023.
//

import Foundation
import SwiftUI

class UpdatePodcastListViewModel: ObservableObject {

    
    private let podcastListService = PodcastListService()
    private let uploadService = UploadService()
    
    @Published var isLoading = false
    
    func updatePodcastList(podcastListId: String, title: String?, description: String?, image: UIImage) {
        isLoading = true
        uploadService.uploadImage(image: image) { result in
            switch result {
                case .success(let url):
                    self.podcastListService.updatePodcastList(podcastListId: podcastListId, title: title, description: description, imageUrl: url) { result in
                        switch result {
                            case .success(let podcastList):
                                print(podcastList)
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
