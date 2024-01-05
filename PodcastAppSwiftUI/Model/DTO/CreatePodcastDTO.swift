//
//  CreatePodcastDTO.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 22.08.2023.
//

import Foundation

struct CreatePodcastDTO: Encodable {
    let title: String
    let description: String
    let imageUrl: String
    let podcastUrl: String
    let isVisible: Bool
    let podcastListId: String
}
