//
//  CreatePodcastListTip.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 16.12.2023.
//

import Foundation
import TipKit

struct CreatePodcastListTip: Tip {
    
    var title: Text {
        Text("Create Podcast List")
    }
    
    var image: Image? {
        Image(systemName: "plus")
    }
    
    var message: Text? {
        Text("You can click here to create a podcast list")
    }
    
}
