//
//  PodcastListsViewModel.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 15.06.2023.
//

import Foundation

class PodcastListsViewModel: ObservableObject {
    
    @Published var podcastLists: Array<PodcastList> = []
    private var podcastListService = PodcastListService()
    @Published var errorString: String?
    @Published var isLoading = false
    
    func fetchPodcastLists() {
        isLoading = true
        podcastListService.fetchMyPodcastLists { [unowned self] result in
            switch result {
                case .success(let podcastLists):
                    self.podcastLists = podcastLists
                case .failure(let error):
                    print(error)
            }
        }
        isLoading = false
    }
    
}
