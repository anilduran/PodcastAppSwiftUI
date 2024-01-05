//
//  PodcastListsScreen.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 15.06.2023.
//

import SwiftUI

struct PodcastListsScreen: View {
    
    @ObservedObject private var viewModel = PodcastListsViewModel()
    @State private var isShowingDeletePodcastList = false
    var createPodcastListTip = CreatePodcastListTip()
    
    var body: some View {
        VStack {
            
            List(viewModel.podcastLists) { podcastList in
                NavigationLink(destination: PodcastListDetailScreen(podcastList: podcastList)) {
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
                                                
                        Spacer()
                            .frame(width: 16)
                        
                        VStack(
                            alignment: .leading
                        ) {
                            Text(podcastList.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.black)
                            Text(podcastList.description)
                                .foregroundStyle(.black)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.black)
                    }
                    .swipeActions {
                        Button(action: {
                            isShowingDeletePodcastList = true
                            
                        }, label: {
                            Label("Delete", systemImage: "trash")
                        })
                        .alert(isPresented: $isShowingDeletePodcastList) {
                            Alert(
                                title: Text("Are you sure?"),
                                message: Text("Are you sure you want to delete this podcast list?"),
                                dismissButton: .default(Text("Delete"))
                            )
                        }
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
                NavigationLink(destination: CreatePodcastListScreen()) {
                    Image(systemName: "plus")
                }
                .popoverTip(createPodcastListTip)
            }
            
        }
        .task {
            viewModel.fetchPodcastLists()
        }
    }
}

struct PodcastListsScreen_Previews: PreviewProvider {
    static var previews: some View {
        PodcastListsScreen()
    }
}
