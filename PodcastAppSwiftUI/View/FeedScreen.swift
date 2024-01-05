//
//  FeedScreen.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 11.06.2023.
//

import SwiftUI

struct FeedScreen: View {
    
    @ObservedObject private var viewModel = FeedViewModel()
    var favoritesTip = FavoritesTip()
    var notificationsTip = NotificationsTip()
    
    var body: some View {
        
        NavigationStack {
            VStack {
                LazyVGrid(
                    columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ]
                ) {
                
                    ForEach(viewModel.podcastLists) { podcastList in
                        NavigationLink(destination: PodcastListDetailScreen(podcastList: podcastList)) {
                            VStack(
                                alignment: .leading
                            ) {
                                AsyncImage(url: URL(string: "\(Constants.BASE_IMAGE_URL)/\(podcastList.imageUrl)")) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    Rectangle()
                                        .foregroundStyle(.gray)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                                Text(podcastList.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.black)
                                Text(podcastList.description)
                                    .foregroundStyle(.gray)
                            }
                        }
                    }
                    
                    
                }
                
                
                
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink(destination: LikedPodcastsScreen()) {
                        Image(systemName: "heart")
                    }
                    .popoverTip(favoritesTip)
                }
                
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink(destination: NotificationsScreen()) {
                        Image(systemName: "bell")
                    }
                    .popoverTip(notificationsTip)
                }
                
            }
            .task {
                viewModel.fetchPodcastLists()
            }
            .navigationTitle("Home")
        }
        
        
        
    }
}

struct FeedScreen_Previews: PreviewProvider {
    static var previews: some View {
        FeedScreen()
    }
}

struct PodcastCard: View {
    
    var podcast: Podcast
    
    var body: some View {
        NavigationLink(destination: ListenPodcastScreen(podcast: podcast)) {
            ZStack(alignment: .bottomLeading) {
                Image("swiftui")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 230)
                    .clipped()
                    .cornerRadius(12)
                
                VStack(alignment: .leading) {
                    Text("Podcast")
                        .foregroundColor(Color.white)
                        

                    HStack {
                        Circle()
                            .frame(width: 30)
                        
                        Text("Anil Duran")
                            .foregroundColor(Color.white)
                    }
                }.padding(10)
                    
                    
            }
        }
    }
}
