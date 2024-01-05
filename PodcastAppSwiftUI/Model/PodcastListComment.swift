//
//  PodcastListComment.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 8.11.2023.
//

import Foundation

struct PodcastListComment: Decodable, Identifiable {
    let id: String
    let content: String
    //let createdAt: Date
    //let updatedAt: Date
    //let isUpdated: Bool
    let user: User
}
