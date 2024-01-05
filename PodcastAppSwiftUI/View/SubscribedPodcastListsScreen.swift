//
//  SubscribedPodcastListsScreen.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 20.10.2023.
//

import SwiftUI

struct SubscribedPodcastListsScreen: View {
    
    @ObservedObject private var viewModel = FollowingPodcastListsViewModel()
    
    var body: some View {
        VStack {
            ForEach(viewModel.podcastLists) { podcastList in
                HStack {
                    AsyncImage(url: URL(string: "\(Constants.BASE_IMAGE_URL)/\(podcastList.imageUrl)")!) { image in
                        if let image = image.image {
                            image
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(6)
                        }
                    }
                    .frame(width: 80, height: 60)
                    VStack(
                        alignment: .leading
                    ) {
                        Text(podcastList.title)
                            .fontWeight(.bold)
                        Text(podcastList.description)
                            .foregroundStyle(.gray)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                }
            }
        }
        .task {
            self.viewModel.fetchFollowingPodcastLists()
        }
        
        
        
    }
}

#Preview {
    SubscribedPodcastListsScreen()
}
