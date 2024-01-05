//
//  LikedPodcastsScreen.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 20.08.2023.
//

import SwiftUI

struct LikedPodcastsScreen: View {
    
    @ObservedObject private var viewModel = LikedPodcastsViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(viewModel.likedPodcasts) { podcast in
                    NavigationLink(destination: ListenPodcastScreen(podcast: podcast)) {
                        HStack {
                            AsyncImage(url: URL(string: "\(Constants.BASE_IMAGE_URL)/\(podcast.imageUrl)")) { image in
                                
                            } placeholder: {
                                Rectangle()
                                    .foregroundStyle(.gray)
                            }
                            .frame(width: 80, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                            
                            VStack(
                                alignment: .leading
                            ) {
                                Text(podcast.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.black)
                                Text(podcast.description)
                                    .foregroundStyle(.gray)
                            }
                            Spacer()
                            Image(systemName: "heart.fill")
                                .foregroundStyle(.black)
                                .onTapGesture {
                                    
                                }
                        }
                    }
                }
            }
            .padding()
        }
        .task {
            viewModel.fetchLikedPodcasts()
        }
    }
}

struct LikedPodcastsScreen_Previews: PreviewProvider {
    static var previews: some View {
        LikedPodcastsScreen()
    }
}
