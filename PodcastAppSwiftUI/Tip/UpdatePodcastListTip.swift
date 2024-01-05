//
//  UpdatePodcastListKit.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 16.12.2023.
//

import Foundation
import TipKit

struct UpdatePodcastListTip: Tip {
    
    var title: Text {
        Text("Update Podcast List")
    }
    
    var image: Image? {
        Image(systemName: "pencil")
    }
    
    var message: Text? {
        Text("You can click here to update the podcast list")
    }
    
}
