//
//  CreatePodcast.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 20.08.2023.
//

import SwiftUI
import PhotosUI

struct CreatePodcastScreen: View {
    
    @State private var title = ""
    @State private var description = ""
    @State private var pickerItem: PhotosPickerItem?
    @State private var image: Image?
    @State private var isFileImporterPresented = false
    @State private var uiImage: UIImage?
    @State private var podcast: Data?
    @State private var player: AVAudioPlayer?
    
    let podcastList: PodcastList
    
    @ObservedObject private var viewModel = CreatePodcastViewModel()
    
    var body: some View {
            

        VStack(
            alignment: .leading,
            spacing: 10
        ) {
            
            Text("Create Podcast")
                .fontWeight(.bold)
                .font(.system(size: 26))
            
            PhotosPicker("Pick an image", selection: $pickerItem, matching: .images)
                
            
            if let image = image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .cornerRadius(6)
                    .clipped()
            }
            
            Button("Pick a file") {
                isFileImporterPresented = true
            }
            .fileImporter(isPresented: $isFileImporterPresented, allowedContentTypes: [.mp3], allowsMultipleSelection: false) { result in
                switch result {
                    case .success(let urls):
                        do {
                            let data = try Data(contentsOf: urls[0])
                            
                            player = try AVAudioPlayer(contentsOf: urls[0])
                            player?.play()
                            print("player will play")
                            
                            self.podcast = data
                        } catch {
                            print(error)
                        }
                    case .failure(let error):
                        print(error)
                }
            }
            HStack {
                TextField("Enter a title", text: $title)
                    .textInputAutocapitalization(.never)
                if title.count > 0 {
                    Image(systemName: "multiply")
                        .onTapGesture {
                            title = ""
                        }
                }
            }
            .padding(16)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.black, lineWidth: 2)
            )
            
            HStack {
                
                TextField("Enter a description", text: $description)
                    .textInputAutocapitalization(.never)
                if description.count > 0 {
                    Image(systemName: "multiply")
                        .onTapGesture {
                            description = ""
                        }
                }
                    
            }
            .padding(16)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.black, lineWidth: 2)
            )
            
            Button(
                action: {
                    if let uiImage, let podcast {
                        viewModel.createPodcast(podcastListId: podcastList.id, title: title, description: description, podcast: podcast, image: uiImage)
                        
                    }
                },
                label: {
                    Text("Create")
                        .padding(16)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(30)
                }
            )
            
            
        }
        .padding()
        .onChange(of: pickerItem) { _ in
            Task {
                if let data = try? await pickerItem?.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        image = Image(uiImage: uiImage)
                        self.uiImage = uiImage
                        return
                    }
                }
            }
        }
    }
}

struct CreatePodcast_Previews: PreviewProvider {
    static var previews: some View {
        CreatePodcastScreen(podcastList: PodcastList(id: "", title: "", description: "", imageUrl: ""))
    }
}
