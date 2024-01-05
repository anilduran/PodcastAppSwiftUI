//
//  PlaylistsScreen.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 15.06.2023.
//

import SwiftUI

struct PlaylistsScreen: View {
    
    @ObservedObject private var viewModel = PlaylistsViewModel()
    var createPlaylistTip = CreatePlaylistTip()
    
    var body: some View {
        VStack {
            
            
            List(viewModel.playlists) { playlist in
                NavigationLink(destination: PlaylistDetailScreen(playlist: playlist)) {
                    HStack {
                        AsyncImage(url: URL(string: "\(Constants.BASE_IMAGE_URL)/\(playlist.imageUrl)")) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            Rectangle()
                                .foregroundStyle(.gray)
                        }
                        .frame(width: 80, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        
                        VStack (
                            alignment: .leading
                        ){
                            Text(playlist.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.black)
                            Text(playlist.description)
                                .foregroundStyle(.black)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.black)
                        
                    }
                    .swipeActions {
                        Button(action: {
                            
                        }, label: {
                            Label("Delete", systemImage: "trash")
                        })
                        .tint(.red)
                        
                        Button(action: {
                            
                        }, label: {
                            Label("Update", systemImage: "pencil")
                        })
                        .tint(.yellow)
                    }
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            
            
            
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                NavigationLink(destination: CreatePlaylistScreen()) {
                    Image(systemName: "plus")
                }
                .popoverTip(createPlaylistTip)
            }
        }
        .task {
            viewModel.fetchPlaylists()
        }
        
    }
}

struct PlaylistsScreen_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistsScreen()
    }
}
