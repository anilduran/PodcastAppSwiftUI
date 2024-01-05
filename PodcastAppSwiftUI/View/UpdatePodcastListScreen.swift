//
//  UpdatePodcastListScreen.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 30.08.2023.
//

import SwiftUI
import PhotosUI

struct UpdatePodcastListScreen: View {
    
    @ObservedObject private var viewModel = UpdatePodcastListViewModel()
    @State private var title = ""
    @State private var description = ""
    @State private var pickerItem: PhotosPickerItem?
    @State private var image: Image?
    @State private var uiImage: UIImage?
    
    private var podcastList: PodcastList
    
    init(podcastList: PodcastList) {
        self.podcastList = podcastList
    }
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 16
        ) {
            
            Text("Update Podcast List")
                .fontWeight(.bold)
                .font(.system(size: 26))
    
            
            PhotosPicker("Pick an image", selection: $pickerItem, matching: .images)
                .onChange(of: pickerItem) { _ in
                    
                    Task {
                        
                        if let data = try? await pickerItem?.loadTransferable(type: Data.self) {
                            if let uiImage = UIImage(data: data) {
                                image = Image(uiImage: uiImage)
                                self.uiImage = uiImage
                            }
                            
                        }
                        
                    }
                }
            
            if let image {
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            } else {
                AsyncImage(url: URL(string: "\(Constants.BASE_IMAGE_URL)/\(podcastList.imageUrl)")!) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Rectangle()
                        .foregroundStyle(.black)
                }
                .clipShape(RoundedRectangle(cornerRadius: 6))
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
                    if let uiImage {
                        self.viewModel.updatePodcastList(podcastListId: podcastList.id, title: title, description: description, image: uiImage)
                    }
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

struct UpdatePodcastListScreen_Previews: PreviewProvider {
    static var previews: some View {
        UpdatePodcastListScreen(podcastList: PodcastList(id: "id", title: "title", description: "description", imageUrl: "imageUrl"))
    }
}
