//
//  CreatePlaylistDTO.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 22.08.2023.
//

import Foundation

struct CreatePlaylistDTO: Encodable {
    let title: String
    let description: String
    let imageUrl: String
}
