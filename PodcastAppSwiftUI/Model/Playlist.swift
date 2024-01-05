//
//  Playlist.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 15.06.2023.
//

import Foundation

struct Playlist: Decodable, Identifiable, Hashable {
    
    let id: String
    let title: String
    let description: String
    let imageUrl: String
    
}
