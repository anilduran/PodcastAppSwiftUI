//
//  PlaylistDetailScreen.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 15.06.2023.
//

import SwiftUI

struct PlaylistDetailScreen: View {
    
    @ObservedObject private var viewModel = PlaylistDetailViewModel()
    var playlist: Playlist
    var updatePlaylistTip = UpdatePlaylistTip()
    
    var body: some View {
        
        VStack(
            alignment: .leading
        ) {

            AsyncImage(url: URL(string: "\(Constants.BASE_IMAGE_URL)/\(playlist.imageUrl)")) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(height: 200)
            }
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            
            Text(playlist.title)
                .fontWeight(.bold)
                .font(.system(size: 24))
            Text(playlist.description)
            
            
            ForEach(viewModel.podcasts) { podcast in
                NavigationLink(destination: ListenPodcastScreen(podcast: podcast)) {
                    HStack {
                        AsyncImage(url: URL(string: "\(Constants.BASE_IMAGE_URL)/\(podcast.imageUrl)")) { image in
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
                            Text(podcast.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.black)
                            Text(podcast.description)
                                .foregroundStyle(.black)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.black)
                    }
                    .swipeActions {
                        Button(
                            action: {
                                
                            },
                            label: {
                                Label("Delete", systemImage: "trash")
                            }
                        )
                        .tint(.red)
                    }
                }
                
            }
            
            
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                NavigationLink(destination: UpdatePlaylistScreen(playlist: playlist)) {
                    Image(systemName: "pencil")
                }
                .popoverTip(updatePlaylistTip)
            }
        }
        .task {
            viewModel.fetchPodcasts(playlistId: playlist.id)
        }
    }
}

struct PlaylistDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistDetailScreen(playlist: Playlist(id: "", title: "", description: "", imageUrl: ""))
    }
}
