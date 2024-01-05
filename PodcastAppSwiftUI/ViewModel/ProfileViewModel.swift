//
//  ProfileViewModel.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 15.06.2023.
//

import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject {
    
    private let userService = UserService()
    private let uploadService = UploadService()
    @Published var currentUser: User? = nil
    @Published var isLoading = false
    
    func uploadProfilePhoto(userId: String, profilePhoto: UIImage) {
        uploadService.uploadImage(image: profilePhoto) { [unowned self] result in
            switch result {
            case .success(let url):
                
                self.userService.updateUser(userId: userId, profilePhotoUrl: url) { [unowned self] result in
                    switch result {
                        case .success(let user):
                            self.currentUser = user
                        case .failure(let error):
                            print(error)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updateUser(
        userId: String,
        username: String? = nil,
        email: String? = nil,
        password: String? = nil
    ) {
        isLoading = true
        userService.updateUser(
            userId: userId,
            username: username,
            email: email,
            password: password
        ) { [unowned self] result in
            
            switch result {
                case .success(let user):
                    self.currentUser = user
                    print(user)
                case .failure(let error):
                    print(error)
            }
        }
        isLoading = false
    }
    
    func fetchCurrentUser() {
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
