//
//  GetPodcastPresignedURLResponse.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 23.08.2023.
//

import Foundation

struct GetPodcastPresignedURLResponse: Decodable {
    let url: String
    let key: String
}
