//
//  LikedPodcastsViewModel.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 22.08.2023.
//

import Foundation

class LikedPodcastsViewModel: ObservableObject {
    
    @Published var likedPodcasts: Array<Podcast> = []
    private let podcastService = PodcastService()
    
    func fetchLikedPodcasts() {
        podcastService.fetchLikedPodcasts { [unowned self] result in
            switch result {
                case .success(let likedPodcasts):
                    self.likedPodcasts = likedPodcasts
                case .failure(let error):
                    print(error)
            }
        }
    }
    
}
