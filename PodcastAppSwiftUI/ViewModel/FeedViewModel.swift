//
//  FeedViewModel.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 15.06.2023.
//

import Foundation


class FeedViewModel: ObservableObject {
    
    private var viewModel = PodcastListService()
    @Published var podcastLists: Array<PodcastList> = []
    @Published var isLoading = false
    
    func fetchPodcastLists() {
        isLoading = true
        viewModel.fetchPodcastLists { [unowned self] result in
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
