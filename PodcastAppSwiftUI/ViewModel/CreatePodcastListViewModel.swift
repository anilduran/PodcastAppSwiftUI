//
//  CreatePodcastListViewModel.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 22.08.2023.
//

import Foundation
import Alamofire

class CreatePodcastListViewModel: ObservableObject {
    
    private let podcastListService = PodcastListService()
    private let uploadService = UploadService()
    @Published var podcastList: PodcastList?
    @Published var isLoading = false
    
    func createPodcastList(title: String, description: String, image: UIImage) {
        isLoading = true
        uploadService.uploadImage(image: image) { [unowned self] result in
            switch result {
                case .success(let url):
                    self.podcastListService.createPodcastList(title: title, description: description, imageUrl: url) { result in
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
