//
//  UpdatePodcastScreen.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 30.08.2023.
//

import SwiftUI
import PhotosUI

struct UpdatePodcastScreen: View {
    
    @ObservedObject private var viewModel = UpdatePodcastViewModel()
    @State private var title = ""
    @State private var description = ""
    @State private var pickerItem: PhotosPickerItem?
    @State private var image: Image?
    @State private var isFileImporterPresented = false
    
    private var podcast: Podcast

    init(podcast: Podcast) {
        self.podcast = podcast
    }
    
    var body: some View {
        
        
        VStack(
            alignment: .leading,
            spacing: 16
        ) {
            
            Text("Update Podcast")
                .fontWeight(.bold)
                .font(.system(size: 26))
            
            PhotosPicker("Pick an image", selection: $pickerItem, matching: .images)
                .onChange(of: pickerItem) { _ in
                    Task {
                        if let data = try? await pickerItem?.loadTransferable(type: Data.self) {
                            if let uiImage = UIImage(data: data) {
                                image = Image(uiImage: uiImage)
                            }
                        }
                    }
                }
            
            if let image {
                image
                    .resizable()
                    .scaledToFit()
            } else {
                AsyncImage(url: URL(string: "\(Constants.BASE_IMAGE_URL)/\(podcast.imageUrl)")!) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Rectangle()
                        .foregroundStyle(.black)
                }
                .clipShape(RoundedRectangle(cornerRadius: 6))
            }
            
            Button("Pick a file") {
                
            }
            .fileImporter(isPresented: $isFileImporterPresented, allowedContentTypes: [.mp3], allowsMultipleSelection: false) { result in
                
                switch result {
                    case .success(let urls):
                        print(urls)
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
                    
                }, label: {
                    Text("Update")
                        .padding(16)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(30)
                }
            )
            
            
        }
        .padding()
        
        
    }
}

struct UpdatePodcastScreen_Previews: PreviewProvider {
    static var previews: some View {
        UpdatePodcastScreen(podcast: Podcast(id: "id", title: "title", description: "description", imageUrl: "imageUrl", podcastUrl: "podcastUrl"))
    }
}
