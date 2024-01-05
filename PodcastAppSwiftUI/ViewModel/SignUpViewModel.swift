//
//  RegisterViewModel.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 15.06.2023.
//

import Foundation

class SignUpViewModel: ObservableObject {
    
    private let authService = AuthService()

    
    func signUp(_ username: String, _ email: String, _ password: String, callback: @escaping () -> Void) {
        authService.signUp(username: username, email: email, password: password) { result in
            switch result {
                case .success(let token):
                    AuthTokenManager.shared.setToken(token)
                    callback()
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    
}
