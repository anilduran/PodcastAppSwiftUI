//
//  UpdateCategoryDTO.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 26.10.2023.
//

import Foundation

struct UpdateCategoryDTO: Encodable {
    let name: String?
    let description: String?
    let imageUrl: String?
}
