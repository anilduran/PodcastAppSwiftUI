//
//  User.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 15.06.2023.
//

import Foundation


struct User: Decodable, Identifiable {

    let id: String
    let username: String
    let email: String
    let profilePhotoUrl: String?
    
}
