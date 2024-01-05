//
//  FavoritesTip.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 16.12.2023.
//

import Foundation
import TipKit

struct FavoritesTip: Tip {
    
    var title: Text {
        Text("Favorites")
    }
    
    var image: Image? {
        Image(systemName: "heart")
    }
    
    var message: Text? {
        Text("You can click here to access your favorite podcasts.")
    }
    
}
