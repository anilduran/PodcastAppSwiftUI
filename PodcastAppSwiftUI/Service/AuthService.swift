//
//  AuthService.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 20.08.2023.
//

import Foundation
import Alamofire



protocol AuthServiceProtocol {
    func signIn(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void)
    func signUp(username: String, email: String, password: String, completion: @escaping (Result<String, Error>) -> Void)
}


struct AuthService: AuthServiceProtocol {
    
    
    
    func signIn(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        let headers: HTTPHeaders = [
            "api-version": "1"
        ]
        
        let signInDTO = SignInDTO(email: email, password: password)
        
        AF.request("\(Constants.BASE_URL)/api/auth/sign-in", method: .post, parameters: signInDTO, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            switch response.result {
                case .success(let data):
                    
                    if let data = data {
                        
                        do {
                            let decoder = JSONDecoder()
                            let authResult = try decoder.decode(AuthResult.self, from: data)
                            completion(.success(authResult.token))
                        } catch {
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func signUp(username: String, email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        let headers: HTTPHeaders = [
            "api-version": "1"
        ]
        
        let signUpDTO = SignUpDTO(username: username, email: email, password: password)
        
        AF.request("\(Constants.BASE_URL)/api/auth/sign-up", method: .post, parameters: signUpDTO, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            switch response.result {
                case .success(let data):
                    if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            let authResult = try decoder.decode(AuthResult.self, from: data)
                            completion(.success(authResult.token))
                            
                        } catch {
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
      
}
