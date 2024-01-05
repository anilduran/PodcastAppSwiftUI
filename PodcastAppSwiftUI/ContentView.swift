//
//  ContentView.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 11.06.2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var authManager = AuthManager()
    
   
    var body: some View {
        
        if authManager.isAuthenticated || AuthTokenManager.shared.getToken() != nil {
            TabView {
                FeedScreen()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                
                SearchScreen()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                
                LibraryScreen()
                    .tabItem {
                        Label("Library", systemImage: "book.fill")
                    }
                
                ProfileScreen()
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
            }
            .environmentObject(authManager)
        } else {
            NavigationStack {
                SignInScreen()
            }
            .environmentObject(authManager)
        }
    }  
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
