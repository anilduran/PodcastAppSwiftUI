//
//  AuthTokenManager.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 20.08.2023.
//

import Foundation
import KeychainSwift

protocol AuthTokenManagerProtocol {
    func setToken(_ token: String) -> Void
    func getToken() -> String?
    func deleteToken()
}

class AuthTokenManager: AuthTokenManagerProtocol, ObservableObject {
    
    private var keychain = KeychainSwift()
    static let shared = AuthTokenManager()
    @Published var isAuthenticated = false
    
    private init() {}
    
    func setToken(_ token: String) -> Void {
        // UserDefaults.standard.set(token, forKey: "authToken")
        keychain.set(token, forKey: "authToken")
    }
    
    func getToken() -> String? {
        // let token = UserDefaults.standard.string(forKey: "authToken")
        let token = keychain.get("authToken")
        return token
    }
    
    func deleteToken() {
        keychain.delete("authToken")
    }
    
}
