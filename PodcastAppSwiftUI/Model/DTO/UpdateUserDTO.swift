//
//  UpdateUserDTO.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 29.10.2023.
//

import Foundation


struct UpdateUserDTO: Encodable {
    let username: String?
    let email: String?
    let password: String?
    let profilePhotoUrl: String?
}
