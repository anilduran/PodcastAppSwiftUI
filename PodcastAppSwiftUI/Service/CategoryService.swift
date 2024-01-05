//
//  CategoryService.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 26.10.2023.
//

import Foundation
import Alamofire

protocol CategoryServiceProtocol {
    func fetchCategories(completion: @escaping (Result<Array<Category>, Error>) -> Void)
    func createCategory(name: String, description: String, imageUrl: String, completion: @escaping (Result<Category, Error>) -> Void)
    func updateCategory(categoryId: String, name: String?, description: String?, imageUrl: String?, completion: @escaping (Result<Category, Error>) -> Void)
    func deleteCategory(categoryId: String, completion: @escaping (Result<Category, Error>) -> Void)
}


class CategoryService: CategoryServiceProtocol {
    func fetchCategories(completion: @escaping (Result<Array<Category>, Error>) -> Void) {
        
        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }
        
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        AF.request("\(Constants.BASE_URL)/api/categories", method: .get, headers: headers).response { response in
            switch response.result {
                case .success(let data):
                    if let data {
                        do {
                            let decoder = JSONDecoder()
                            let categories = try decoder.decode(Array<Category>.self, from: data)
                            completion(.success(categories))
                            
                        } catch {
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
                
            }
        }
        
    }
    
    func createCategory(name: String, description: String, imageUrl: String, completion: @escaping (Result<Category, Error>) -> Void) {
        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }
        
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        let createCategoryDTO = CreateCategoryDTO(name: name, description: description, imageUrl: imageUrl)
        
        AF.request("\(Constants.BASE_URL)/api/categories", method: .post, parameters: createCategoryDTO, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            
            
            
        }
        
    }
    
    func updateCategory(categoryId: String, name: String? = nil, description: String? = nil, imageUrl: String? = nil, completion: @escaping (Result<Category, Error>) -> Void) {
        
        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }
            
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]

        let updateCategoryDTO = UpdateCategoryDTO(name: name, description: description, imageUrl: imageUrl)
        
        AF.request("\(Constants.BASE_URL)/api/categories/\(categoryId)", method: .put, parameters: updateCategoryDTO, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            switch response.result {
                case .success(let data):
                    if let data {
                        do {
                            let category = try JSONDecoder().decode(Category.self, from: data)
                            completion(.success(category))
                        } catch {
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func deleteCategory(categoryId: String, completion: @escaping (Result<Category, Error>) -> Void) {
        guard let token = AuthTokenManager.shared.getToken() else {
            return
        }
        
        let headers: HTTPHeaders = [
            "x-access-token": token,
            "api-version": "1"
        ]
        
        AF.request("\(Constants.BASE_URL)/api/categories/\(categoryId)", method: .delete, headers: headers).response { response in
            switch response.result {
                case .success(let data):
                    if let data {
                        do {
                            let category = try JSONDecoder().decode(Category.self, from: data)
                            completion(.success(category))
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
