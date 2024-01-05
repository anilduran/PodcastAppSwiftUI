//
//  LibraryScreen.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 15.06.2023.
//

import SwiftUI

struct LibraryScreen: View {
    
    @ObservedObject private var viewModel = LibraryViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(
                alignment: .leading
            ) {
                
                NavigationLink(destination: PodcastListsScreen()) {
                    HStack {
                        VStack(
                            alignment: .leading
                        ) {
                            Text("Your Podcast Lists")
                                .fontWeight(.bold)
                                .foregroundStyle(.black)
                            Text("You can access your own podcast lists here.")
                                .foregroundStyle(.gray)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.black)
                    }
                }
                
                Spacer()
                    .frame(height: 20)
                    
                
                NavigationLink(destination: PlaylistsScreen()) {
                    HStack {
                        VStack(
                            alignment: .leading
                        ) {
                            Text("Your Playlists")
                                .fontWeight(.bold)
                                .foregroundStyle(.black)
                            Text("You can access your own playlists here.")
                                .foregroundStyle(.gray)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.black)
                    }
                }
                
                Text("Following Podcast Lists")
                    .fontWeight(.bold)
                    .font(.system(size: 24))
                
                ForEach(viewModel.podcastLists) { podcastList in
                    NavigationLink(destination: LibraryDetailScreen(podcastList: podcastList)) {
                        HStack {
                            AsyncImage(url: URL(string: "\(Constants.BASE_IMAGE_URL)/\(podcastList.imageUrl)")) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                Rectangle()
                                    .foregroundStyle(.gray)
                            }
                            .frame(width: 80, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                            
                            VStack(
                                alignment: .leading
                            ) {
                                Text(podcastList.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.black)
                                Text(podcastList.description)
                                    .foregroundStyle(.gray)
                                
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.black)
                        }
                    }
                }
                
            }
            .navigationTitle("Library")
            .padding()
            .task {
                viewModel.fetchFollowingPodcastLists()
            }
        }
    }
}

struct LibraryScreen_Previews: PreviewProvider {
    static var previews: some View {
        LibraryScreen()
    }
}
