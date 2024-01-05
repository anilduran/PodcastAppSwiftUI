//
//  AuthManager.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 14.12.2023.
//

import Foundation


class AuthManager: ObservableObject {
    
    private var userService = UserService()
    var currentUser: User?
    
    
    @Published var isAuthenticated = false
    
    
    init() {
        userService.fetchCurrentUser { [unowned self] result in
            switch result {
            case .success(let user):
                self.currentUser = user
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
