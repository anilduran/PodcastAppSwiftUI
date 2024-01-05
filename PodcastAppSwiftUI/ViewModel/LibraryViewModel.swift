//
//  LibraryViewModel.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 15.06.2023.
//

import Foundation

class LibraryViewModel: ObservableObject {
    
    private let podcastListService = PodcastListService()
    @Published var podcastLists: Array<PodcastList> = []
    
    func fetchFollowingPodcastLists() {
        podcastListService.fetchPodcastLists { result in
            switch result {
                case .success(let podcastLists):
                    self.podcastLists = podcastLists
                case .failure(let error):
                    print(error)
            }
            
        }
    }
    
    func unfollowPodcastList(podcastListId: String) {
        podcastListService.unfollowPodcastList(podcastListId: podcastListId) { result in
            switch result {
                case .success(let podcastList):
                    print(podcastList)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    
}
