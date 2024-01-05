//
//  LoginViewModel.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 15.06.2023.
//

import Foundation


class SignInViewModel: ObservableObject {
    
    private let authService = AuthService()
    
    func signIn(_ email: String, _ password: String, callback: @escaping () -> Void) {
        authService.signIn(email: email, password: password) { result in
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
