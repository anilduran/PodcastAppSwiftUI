//
//  LibraryDetailViewModel.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 15.06.2023.
//

import Foundation

class LibraryDetailViewModel: ObservableObject {
    
    private let podcastListService = PodcastListService()
    @Published var podcasts: Array<Podcast> = []
    @Published var comments: Array<PodcastListComment> = []
    @Published var creator: User? = nil
    
    func fetchPodcasts(podcastListId: String) {
        podcastListService.fetchPodcasts(podcastListId: podcastListId) { [unowned self] result in
            switch result {
                case .success(let podcasts):
                    self.podcasts = podcasts
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func fetchComments(podcastListId: String) {
        podcastListService.fetchComments(podcastListId: podcastListId) { [unowned self] result in
            switch result {
                case .success(let podcastListComments):
                    self.comments = podcastListComments
                case .failure(let error):
                    print(error)
                
            }
            
        }
    }
    
    func createComment(podcastListId: String, comment: String) {
        podcastListService.createComment(podcastListId: podcastListId, content: comment) { result in
            switch result {
                case .success(let podcastListComment):
                    print(podcastListComment)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func updateComment(podcastListId: String, commentId: String, comment: String?) {
        podcastListService.updateComment(podcastListId: podcastListId, commentId: commentId, content: comment) { result in
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
