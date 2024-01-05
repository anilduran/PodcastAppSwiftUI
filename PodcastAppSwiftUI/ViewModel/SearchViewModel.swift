//
//  SearchViewModel.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 15.06.2023.
//

import Foundation

class SearchViewModel: ObservableObject {
    
    private let podcastListService = PodcastListService()
    @Published var podcastLists = []
    @Published var isLoading = false
    
    func search(text: String) {
        isLoading = true
        podcastListService.search(text: text) { [unowned self] result in
            switch result {
                case .success(let podcastLists):
                    print(podcastLists)
                    self.podcastLists = podcastLists
                case .failure(let error):
                    print(error)
            }
        }
        isLoading = false
    }
    
    
}
