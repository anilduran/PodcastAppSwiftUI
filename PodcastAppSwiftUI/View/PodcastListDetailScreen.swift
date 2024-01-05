//
//  PodcastListDetailScreen.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 15.06.2023.
//

import SwiftUI

struct PodcastListDetailScreen: View {
    
    @ObservedObject private var viewModel = PodcastListDetailViewModel()
    @State private var isCommentSheetShowing = false
    @State private var comment = ""
    var podcastList: PodcastList
    var createPodcastTip = CreatePodcastTip()
    var updatePodcastListTip = UpdatePodcastListTip()
    
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
                        .foregroundStyle(Color.black)
                        .frame(height: 200)
                }
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                
                Text("Podcast List Title")
                    .fontWeight(.bold)
                    .font(.system(size: 24))
                
                Text("Podcast list description")
                
            }
            .padding()
            
            Button(
                action: {
                    isCommentSheetShowing.toggle()
                },
                label: {
                    HStack {
                        Image(systemName: "text.bubble")
                        Text("Comments")
                    }
                    .frame(maxWidth: .infinity)
                    .padding(16)
                    .foregroundStyle(.white)
                    .background(.black)
                    .cornerRadius(30)
                }
            )
            .sheet(isPresented: $isCommentSheetShowing) {
                VStack(
                    alignment: .leading
                ) {
                    
                    Spacer()
                        .frame(height: 20)

                    Text("Enter a Comment")
                        .fontWeight(.bold)
                        .font(.system(size: 24))
                    
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
                            viewModel.createComment(podcastListId: podcastList.id, content: comment)
                        },
                        label: {
                            HStack {
                                Image(systemName: "plus")
                                Text("Create")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundStyle(.white)
                            .background(.black)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                        }
                    )

                    
                    Text("Comment - \(viewModel.podcastListComments.count)")
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                    
                    ScrollView {
                        ForEach(viewModel.podcastListComments) { podcastListComment in
                            HStack {
                                AsyncImage(url: URL(string: "\(Constants.BASE_IMAGE_URL)/\(podcastListComment.user.profilePhotoUrl ?? "")")) { image in
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
                                    Text(podcastListComment.user.username)
                                        .fontWeight(.bold)
                                    Text(podcastListComment.content)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    
                    
                }
                .padding()
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(30)
            }
                
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
                }
            }

        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                NavigationLink(destination: CreatePodcastScreen(podcastList: podcastList)) {
                    Image(systemName: "plus")
                }
                .popoverTip(createPodcastTip)
            }
            ToolbarItem(placement: .primaryAction) {
                NavigationLink(destination: UpdatePodcastListScreen(podcastList: podcastList)) {
                    Image(systemName: "pencil")
                }
                .popoverTip(updatePodcastListTip)
            }
        }
        .task {
            viewModel.fetchPodcasts(podcastListId: podcastList.id)
            viewModel.fetchComments(podcastListId: podcastList.id)
            viewModel.fetchCreator(podcastListId: podcastList.id)
        }
        
    }
}

struct PodcastListDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        PodcastListDetailScreen(podcastList: PodcastList(id: "", title: "", description: "", imageUrl: ""))
    }
}
