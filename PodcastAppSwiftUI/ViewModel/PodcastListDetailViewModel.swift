//
//  PodcastListDetailViewModel.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 15.06.2023.
//

import Foundation

class PodcastListDetailViewModel: ObservableObject {
    
    @Published var podcastList: PodcastList?
    private var podcastListService = PodcastListService()
    @Published var errorString: String?
    @Published var podcastListComments: Array<PodcastListComment> = []
    @Published var podcasts: Array<Podcast> = []
    @Published var creator: User? = nil
    
    @Published var isFetchPodcastsLoading = false
    
    func fetchPodcasts(podcastListId: String) {
        isFetchPodcastsLoading = true
        podcastListService.fetchPodcasts(podcastListId: podcastListId) { [unowned self] result in
            switch result {
                case .success(let podcasts):
                    self.podcasts = podcasts
                case .failure(let error):
                    print(error)
            }
        }
        isFetchPodcastsLoading = false
    }
    
    func deletePodcastList(podcastListId: String) {
        podcastListService.deletePodcastList(podcastListId: podcastListId) { [unowned self] result in
            switch result {
                case .success(let podcastList):
                    self.podcastList = podcastList
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func fetchComments(podcastListId: String) {
        podcastListService.fetchComments(podcastListId: podcastListId) { [unowned self] result in
            switch result {
                case .success(let podcastListComments):
                    self.podcastListComments = podcastListComments
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    
    func createComment(podcastListId: String, content: String) {
        podcastListService.createComment(podcastListId: podcastListId, content: content) { [unowned self] result in
            switch result {
                case .success(let podcastListComment):
                    self.podcastListComments.append(podcastListComment)
                case .failure(let error):
                    print(error)
            }
            
        }
    }
    
    func updateComment(podcastListId: String, commentId: String, content: String?) {
        podcastListService.updateComment(podcastListId: podcastListId, commentId: commentId, content: content) { result in
            switch result {
                case .success(let podcastListComment):
                    print(podcastListComment)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func deleteComment(podcastListId: String, commentId: String) {
        podcastListService.deleteComment(podcastListId: podcastListId, commentId: commentId) { result in
            switch result {
                case .success(let podcastListComment):
                    print(podcastListComment)
                case .failure(let error):
                    print(error)  
            }
            
        }
    }
    
    func fetchCreator(podcastListId: String) {
        podcastListService.fetchCreator(podcastListId: podcastListId) { [unowned self] result in
            switch result {
                case .success(let user):
                    self.creator = user
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    
}
