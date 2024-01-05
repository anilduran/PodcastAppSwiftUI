//
//  LibraryDetailScreen.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 15.06.2023.
//

import SwiftUI

struct LibraryDetailScreen: View {
    
    @ObservedObject private var viewModel = LibraryDetailViewModel()
    var podcastList: PodcastList
    @State var isCommentSheetShowing = false
    @State var comment = ""
    
    var body: some View {
        VStack {
            
            VStack(
                alignment: .leading,
                spacing: 16
            ) {
                
                AsyncImage(url: URL(string: "\(Constants.BASE_IMAGE_URL)/\(podcastList.imageUrl)")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Rectangle()
                        .foregroundStyle(.gray)
                        .frame(height: 200)
                }
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                
                
                if let creator = viewModel.creator {
                   
                    HStack {
                        
                        AsyncImage(url: URL(string: "\(Constants.BASE_IMAGE_URL)/\(creator.profilePhotoUrl ?? "")")) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                            
                        } placeholder: {
                            Circle()
                                .foregroundStyle(.black)
                        }
                        .frame(width: 50)
                        
                        NavigationLink(destination: UserDetailScreen(user: creator)) {
                            Text(creator.username)
                                .foregroundStyle(.black)
                        }
                        
                        
                        
                    }
                    
                    
                }
                
                HStack {
                    Text(podcastList.title)
                        .fontWeight(.bold)
                        .font(.system(size: 26))
                    Spacer()
                    
                    Button("Unsubscribe") {
                        
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.black)
                }
                Text(podcastList.description)
                
                Button(
                    action: {
                        isCommentSheetShowing.toggle()
                    },
                    label: {
                        Text("Comments - \(viewModel.comments.count)")
                            .frame(maxWidth: .infinity)
                            .padding(16)
                            .background(.black)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                    }
                )
                .sheet(isPresented: $isCommentSheetShowing) {
                    VStack(
                        alignment: .leading
                    ) {
                        Text("Create Comment")
                            .fontWeight(.bold)
                            .font(.system(size: 26))
                        
                        HStack {
                            Image(systemName: "text.bubble")
                            TextField("Enter a comment", text: $comment)
                            if !comment.isEmpty {
                                Image(systemName: "multiply")
                                    .onTapGesture {
                                        comment = ""
                                    }
                            }
                        }
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(.black, lineWidth: 2)
                        )
                        
                        Button(
                            action: {
                                viewModel.createComment(podcastListId: podcastList.id, comment: comment)
                            },
                            label: {
                                HStack {
                                    Image(systemName: "plus")
                                    Text("Create")
                                }
                                .frame(maxWidth: .infinity)
                                .padding(16)
                                .background(.black)
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                            }
                        )
                        
                        Text("Comments - \(viewModel.comments.count)")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                        
                        ScrollView {
                            ForEach(viewModel.comments) { comment in
                                HStack {
                                    AsyncImage(url: URL(string: "\(Constants.BASE_IMAGE_URL)/\(comment.user.profilePhotoUrl ?? "")")) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .clipShape(Circle())
                                    } placeholder: {
                                        Circle()
                                            .foregroundStyle(.black)
                                    }
                                    .frame(width: 40)
                                    
                                    VStack(
                                        alignment: .leading
                                    ) {
                                        Text(comment.user.username)
                                            .fontWeight(.bold)
                                        Text(comment.content)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                    .padding()
                }
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(30)
                
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
                        }
                    }
                }
                
            }
            .padding()
        }
        .task {
            viewModel.fetchPodcasts(podcastListId: podcastList.id)
            viewModel.fetchComments(podcastListId: podcastList.id)
            viewModel.fetchCreator(podcastListId: podcastList.id)
        }
    }
}

struct LibraryDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        LibraryDetailScreen(podcastList: PodcastList(id: "", title: "", description: "", imageUrl: ""))
    }
}
