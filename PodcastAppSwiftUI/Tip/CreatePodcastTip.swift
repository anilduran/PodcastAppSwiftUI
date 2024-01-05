//
//  CreatePodcastTip.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 16.12.2023.
//

import Foundation
import TipKit


struct CreatePodcastTip: Tip {
    
    var title: Text {
        Text("Create Podcast")
    }
    
    var message: Text? {
        Text("You can click here to create a podcast")
    }
    
    var image: Image? {
        Image(systemName: "plus")
    }
}
