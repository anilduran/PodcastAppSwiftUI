//
//  NotificationsTip.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 16.12.2023.
//

import Foundation
import TipKit

struct NotificationsTip: Tip {
    var title: Text {
        Text("Notifications")
    }
    
    var image: Image? {
        Image(systemName: "bell")
    }
    
    var message: Text? {
        Text("You can click here to access your notifications.")
    }
}
