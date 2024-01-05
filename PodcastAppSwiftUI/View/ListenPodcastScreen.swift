//
//  ListenPodcastScreen.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 15.06.2023.
//

import SwiftUI
import AVFoundation

struct ListenPodcastScreen: View {
    
    @ObservedObject private var viewModel = ListenPodcastViewModel()
    @State private var isPlaylistSheetShowing = false
    @State private var isCommentSheetShowing = false
    @State private var comment = ""
    var podcast: Podcast
    @State private var player: AVPlayer?
    var updatePodcastTip = UpdatePodcastTip()
    @State private var currentSecond = 0.0
    @State private var isPlaying = false
    @State private var totalSeconds = 0.0
    
    func formatTime(seconds: Int) -> String {
        let minutes = seconds / 60
        let minutesString = minutes < 10 ? "0\(minutes)" : "\(minutes)"
        
        let seconds = seconds - minutes * 60
        let secondsString = seconds < 10 ? "0\(seconds)" : "\(seconds)"
        
        return "\(minutesString):\(secondsString)"
    }
    
    func initializeAudioPlayer() {

        let url = URL(string:"\(Constants.BASE_PODCAST_URL)/\(podcast.podcastUrl)")!
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        
        let timeInterval = CMTime(seconds: 1.0, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        let queue = DispatchQueue.main
        
        
        print(totalSeconds)
        player?.addPeriodicTimeObserver(forInterval: timeInterval, queue: queue) { time in
            totalSeconds = playerItem.duration.seconds.rounded(.down)
            currentSecond = time.seconds.rounded(.down)
            if player?.rate != 0.0 {
                isPlaying = true
            } else {
                isPlaying = false
            }
        }
        
        player?.play()
    }
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 16
        ) {
            Text(formatTime(seconds: Int(currentSecond)))
            ZStack(
                alignment: .topTrailing
            ) {
                
               
                AsyncImage(url: URL(string: "\(Constants.BASE_IMAGE_URL)/\(podcast.imageUrl)")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Rectangle()
                        .frame(height: 250)
                        .foregroundStyle(.black)
                        
                }
                .clipShape(RoundedRectangle(cornerRadius: 6))
                
                VStack(
                    spacing: 16
                ) {
                    Image(systemName: "heart")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                        .onTapGesture {
                            viewModel.likePodcast(podcastId: podcast.id)
                        }
                    Image(systemName: "bookmark")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                        .onTapGesture {
                            isPlaylistSheetShowing = true
                        }
                        .sheet(isPresented: $isPlaylistSheetShowing) {
                            VStack {
                                HStack {
                                    Text("Add To Playlist")
                                        .fontWeight(.bold)
                                        .font(.system(size: 26))
                                        .padding()
                                    Spacer()
                                    NavigationLink(destination: CreatePlaylistScreen()) {
                                        Image(systemName: "plus")
                                    }
                                }
                        
                                
                                ScrollView {
                                    ForEach(viewModel.playlists) { playlist in
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
                                            VStack(
                                                alignment: .leading
                                            ) {
                                                Text(playlist.title)
                                                    .fontWeight(.bold)
                                                Text(playlist.description)
                                            }
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                        }
                                        .onTapGesture {
                                            viewModel.addPodcastToPlaylist(playlistId: playlist.id, podcastId: podcast.id)
                                        }
                                    }
                                }
                            }
                            .padding()
                            .presentationDragIndicator(.visible)
                            .presentationDetents([.medium])
                            .presentationCornerRadius(30)
                        }
                }
                .padding()
            }
            
            Text(podcast.title)
                .fontWeight(.bold)
                .font(.system(size: 26))
            
            Text(podcast.description)
        
            Slider(value: $currentSecond, in: 0...totalSeconds)
            HStack {
                Text(formatTime(seconds: Int(currentSecond)))
                Spacer()
                Text(formatTime(seconds: Int(totalSeconds)))
            }
            
            HStack(
                
            ) {
                Spacer()
                Button(action: {
                    
                }, label: {
                    Image(systemName: "backward.fill")
                        .font(.system(size: 26))
                        .foregroundStyle(.black)
                })
                Spacer()
                Button(action: {
                    
                    if isPlaying {
                        player?.pause()
                    } else {
                        player?.play()
                    }
                
                    
                }, label: {
                    
                    if isPlaying {
                        Image(systemName: "pause.fill")
                            .font(.system(size: 26))
                            .foregroundStyle(.black)
                    } else {
                        Image(systemName: "play.fill")
                            .font(.system(size: 26))
                            .foregroundStyle(.black)
                    }
                    
                })
        
                Spacer()
                Button(action: {
                  
                }, label: {
                    Image(systemName: "forward.fill")
                        .font(.system(size: 26))
                        .foregroundStyle(.black)
                })
                Spacer()
            }
            
            Spacer()
                .frame(height: 10)
            
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
                    .background(.black)
                    .foregroundStyle(.white)
                    .cornerRadius(30)
                }
            )
            .sheet(isPresented: $isCommentSheetShowing) {
                VStack(
                    alignment: .leading
                ) {
                    
                    Text("Create a Comment")
                        .fontWeight(.bold)
                        .font(.system(size: 24))
                    
                    HStack {
                        Image(systemName: "text.bubble")
                        TextField("Enter a comment", text: $comment)
                            .textInputAutocapitalization(.never)
                        if !comment.isEmpty {
                            Image(systemName: "multiply")
                                .onTapGesture {
                                    comment = ""
                                }
                        }
                    }
                    .padding(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .strokeBorder(Color.black, lineWidth: 2)
                    )
                    
                    Button(
                        action: {
                            Task {
                                viewModel.createComment(podcastId: podcast.id, content: comment)
                            }
                        },
                        label: {
                            HStack {
                                Image(systemName: "plus")
                                Text("Add")
                            }
                            .frame(maxWidth: .infinity)
                            .padding(16)
                            .foregroundStyle(.white)
                            .background(.black)
                            .cornerRadius(30)
                        }
                    )
                    
                    Text("Comments - \(viewModel.podcastComments.count)")
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                    
                    ScrollView {
                        ForEach(viewModel.podcastComments) { podcastComment in
                            HStack(
                                spacing: 10
                            ) {
                                AsyncImage(url: URL(string: "\(Constants.BASE_IMAGE_URL)/\(podcastComment.user.profilePhotoUrl ?? "")")) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .clipShape(Circle())
                                } placeholder: {
                                    Circle()
                                        .foregroundStyle(.gray)
                                }
                                .frame(width: 40)
                                VStack(
                                    alignment: .leading
                                ) {
                                    Text(podcastComment.user.username)
                                        .fontWeight(.bold)
                                    Text(podcastComment.content)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }

                    
                }
                .padding()
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(30)
            }
        }
        .padding()
        .task {
            viewModel.fetchComments(podcastId: podcast.id)
            viewModel.fetchPlaylists()
            initializeAudioPlayer()
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                NavigationLink(destination: UpdatePodcastScreen(podcast: self.podcast)) {
                    Image(systemName: "pencil")
                }
                .popoverTip(updatePodcastTip)
            }
        }
    }
}

struct ListenPodcastScreen_Previews: PreviewProvider {
    static var previews: some View {
        ListenPodcastScreen(podcast: Podcast(id: "", title: "", description: "", imageUrl: "", podcastUrl: ""))
    }
}
