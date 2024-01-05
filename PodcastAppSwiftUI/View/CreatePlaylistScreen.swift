//
//  CreatePlaylistScreen.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 20.08.2023.
//

import SwiftUI
import PhotosUI

struct CreatePlaylistScreen: View {
    
    private var viewModel = CreatePlaylistViewModel()
    @State private var title = ""
    @State private var description = ""
    @State private var pickerItem: PhotosPickerItem?
    @State private var image: Image?
    @State private var uiImage: UIImage?
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 16
        ) {
            
            Text("Create Playlist")
                .fontWeight(.bold)
                .font(.system(size: 26))
            
            PhotosPicker("Pick an image", selection: $pickerItem)
                .onChange(of: pickerItem) { _ in
                    
                    Task {
                        if let data = try? await pickerItem?.loadTransferable(type: Data.self) {
                            if let uiImage = UIImage(data: data) {
                                self.uiImage = uiImage
                                image = Image(uiImage: uiImage)
                                return
                            }
                        }
                    }
                    
                    
                }
            
            if let image = image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: .infinity)
                    .clipped()
                    .cornerRadius(6)
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
                        viewModel.createPlaylist(title: title, description: description, image: uiImage)
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
    }
}

struct CreatePlaylistScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreatePlaylistScreen()
    }
}
