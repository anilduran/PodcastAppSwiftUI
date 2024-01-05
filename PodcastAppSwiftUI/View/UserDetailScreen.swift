//
//  UserDetailScreen.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 11.11.2023.
//

import SwiftUI

struct UserDetailScreen: View {
    
    let user: User
    @ObservedObject var viewModel = UserDetailViewModel()
    
    var body: some View {
       
        VStack(
            alignment: .leading
        ) {
            
            HStack {
                AsyncImage(url: URL(string: "\(Constants.BASE_IMAGE_URL)/\(user.profilePhotoUrl ?? "")")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                } placeholder: {
                    Circle()
                        .foregroundStyle(.black)
                }
                .frame(width: 50)
                
                Text(user.username)
            }
            
            ForEach(viewModel.podcastLists) { podcastList in
                
                
                NavigationLink(destination: LibraryDetailScreen(podcastList: podcastList)) {
                    HStack {
                        
                        AsyncImage(url: URL(string: "\(Constants.BASE_IMAGE_URL)/\(podcastList.imageUrl)")!) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            Rectangle()
                                .foregroundStyle(.black)
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
        .padding()
        .task {
            viewModel.fetchPodcastLists(userId: user.id)
        }
        
    }
}

#Preview {
    UserDetailScreen(user: User(id: "", username: "", email: "", profilePhotoUrl: ""))
}
