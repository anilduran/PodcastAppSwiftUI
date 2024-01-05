//
//  PodcastAppSwiftUIApp.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 11.06.2023.
//

import SwiftUI
import TipKit

@main
struct PodcastAppSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    //try? Tips.resetDatastore()
                    try? Tips.configure([
                        .datastoreLocation(.applicationDefault),
                        .displayFrequency(.immediate)
                    ])
                }
        }
    }
}
