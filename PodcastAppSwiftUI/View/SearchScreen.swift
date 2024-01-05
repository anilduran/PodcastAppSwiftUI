//
//  SearchScreen.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 15.06.2023.
//

import SwiftUI

struct SearchScreen: View {
    
    @ObservedObject private var viewModel = SearchViewModel()
    @State private var searchText = ""
    
    var body: some View {

        NavigationStack{
            VStack {
                
                VStack(
                    alignment: .leading,
                    spacing: 16
                ) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Search something...", text: $searchText)
                            .textInputAutocapitalization(.never)
                        if searchText.count > 0 {
                            Image(systemName: "multiply")
                                .onTapGesture {
                                    searchText = ""
                                }
                        }
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.black, lineWidth: 2)
                    )
                }
                .padding()
                
                List {
                    
                }
                
            }
            .navigationTitle("Search")
        }
        
    }
}

struct SearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreen()
    }
}
