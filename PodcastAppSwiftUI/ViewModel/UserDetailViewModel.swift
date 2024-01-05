//
//  UserDetailViewModel.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 16.12.2023.
//

import Foundation

class UserDetailViewModel: ObservableObject {
    
    private var userService = UserService()
    @Published var podcastLists: Array<PodcastList> = []
    
    func fetchPodcastLists(userId: String) {
        userService.fetchPodcastLists(userId: userId) { [unowned self] result in
            switch result {
                case .success(let podcastLists):
                    self.podcastLists = podcastLists
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    
}
