//
//  Podcast.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 15.06.2023.
//

import Foundation

struct Podcast: Decodable, Identifiable {
    
    let id: String
    let title: String
    let description: String
    let imageUrl: String
    let podcastUrl: String
    
}
