//
//  SubscribedPodcastListsViewModel.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 20.10.2023.
//

import Foundation


class FollowingPodcastListsViewModel: ObservableObject {
    
    private let podcastListService = PodcastListService()
    @Published var podcastLists = [PodcastList]()
    
    func fetchFollowingPodcastLists() {
        podcastListService.fetchFollowingPodcastLists { [unowned self] result in
            switch result {
                case .success(let podcastLists):
                    self.podcastLists = podcastLists
                case .failure(let error):
                    print(error)

            }
        }
    }
    
    
}
