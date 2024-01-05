//
//  CreatePlaylistTip.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 16.12.2023.
//

import Foundation
import TipKit


struct CreatePlaylistTip: Tip {
    
    var title: Text {
        Text("Create Playlist")
    }
    
    var image: Image? {
        Image(systemName: "plus")
    }
    
    var message: Text? {
        Text("You can click here to create a playlist")
    }
    
}
