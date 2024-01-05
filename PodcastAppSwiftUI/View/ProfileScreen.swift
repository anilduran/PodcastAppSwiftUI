//
//  ProfileScreen.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 15.06.2023.
//

import SwiftUI

struct ProfileScreen: View {
    
    @ObservedObject private var viewModel = ProfileViewModel()
    
    @State private var isChangeUsernameSheetOpened = false
    @State private var isChangeEmailSheetOpened = false
    @State private var isChangePasswordSheetOpened = false
    
    @State private var isSignOutConfirmationDialogPresented = false
    
    @State private var currentUsername = ""
    @State private var newUsername = ""
    
    @State private var currentEmail = ""
    @State private var newEmail = ""
    
    @State private var currentPassword = ""
    @State private var newPassword = ""
    
    @EnvironmentObject var authManager: AuthManager

    var body: some View {
        
        NavigationStack {
            List {
                HStack(
                    spacing: 10
                ) {
                    Circle()
                        .foregroundColor(.blue)
                        .frame(width: 60)
                    
                    VStack(
                        alignment: .leading
                    ) {
                        if let user = viewModel.currentUser {
                            Text(user.username)
                                .fontWeight(.bold)
                            Text(user.email)
                                .foregroundStyle(.gray)
                        }
                    }
                }
                
                HStack {
                    Image(systemName: "arrow.forward.circle")
                    Text("Sign out")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .onTapGesture {
                    isSignOutConfirmationDialogPresented.toggle()
                }
                .confirmationDialog("SignOutConfirmationDialog", isPresented: $isSignOutConfirmationDialogPresented) {
                    Button(
                        action: {
                            AuthTokenManager.shared.deleteToken()
                            authManager.isAuthenticated = false
                        },
                        label: {
                            Text("Yes")
                        }
                    )
                } message: {
                    Text("Are you sure you want to sign out?")
                }

                HStack {
                    Image(systemName: "person")
                    Text("Change Username")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .onTapGesture {
                    isChangeUsernameSheetOpened = true
                }
                .sheet(isPresented: $isChangeUsernameSheetOpened) {
                    VStack(
                        alignment: .leading,
                        spacing: 16
                    ) {
                        Text("Change Username")
                            .fontWeight(.bold)
                            .font(.system(size: 26))
                        
                        HStack {
                            Image(systemName: "person")
                            TextField("Enter your current username", text: $currentUsername)
                                .textInputAutocapitalization(.never)
                            if currentUsername.count > 0 {
                                Image(systemName: "multiply")
                                    .onTapGesture {
                                        currentUsername = ""
                                    }
                            }
                        }
                        .padding(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.black, lineWidth: 2)
                        )
                        
                        HStack {
                            Image(systemName: "person")
                            TextField("Enter a username", text: $newUsername)
                                .textInputAutocapitalization(.never)
                            if newUsername.count > 0 {
                                Image(systemName: "multiply")
                                    .onTapGesture {
                                        newUsername = ""
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
                                Task {
                                    if let userId = viewModel.currentUser?.id, currentUsername == viewModel.currentUser?.username {
                                        viewModel.updateUser(userId: userId, username: newUsername)
                                        currentUsername = ""
                                        newUsername = ""
                                        isChangeUsernameSheetOpened = false
                                    }
                                }
                            },
                            label: {
                                Text("Change")
                                    .padding(16)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(.white)
                                    .background(.black)
                                    .cornerRadius(30)
                            }
                        )
                    }
                    .padding()
                    .presentationDragIndicator(.visible)
                    .presentationDetents([.medium])
                    .presentationCornerRadius(30)
                }
                
                HStack {
                    Image(systemName: "envelope")
                    Text("Change Email")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .onTapGesture {
                    isChangeEmailSheetOpened = true
                }
                .sheet(isPresented: $isChangeEmailSheetOpened) {
                    VStack(
                        alignment: .leading,
                        spacing: 16
                    ) {
                        Text("Change Email")
                            .fontWeight(.bold)
                            .font(.system(size: 26))
                        
                        HStack {
                            Image(systemName: "envelope")
                            TextField("Enter your current email", text: $currentEmail)
                                .textInputAutocapitalization(.never)
                            if currentEmail.count > 0 {
                                Image(systemName: "multiply")
                                    .onTapGesture {
                                        currentEmail = ""
                                    }
                            }
                        }
                        .padding(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.black, lineWidth: 2)
                        )
                        
                        HStack {
                            Image(systemName: "envelope")
                            TextField("Enter an email", text: $newEmail)
                                .textInputAutocapitalization(.never)
                            if newEmail.count > 0 {
                                Image(systemName: "multiply")
                                    .onTapGesture {
                                        newEmail = ""
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
                                Task {
                                    if let userId = viewModel.currentUser?.id, currentEmail == viewModel.currentUser?.email {
                                        viewModel.updateUser(userId: userId, email: newEmail)
                                        currentEmail = ""
                                        newEmail = ""
                                        isChangeEmailSheetOpened = false
                                    }
                                }
                            },
                            label: {
                                Text("Change")
                                    .padding(16)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(.white)
                                    .background(.black)
                                    .cornerRadius(30)
                            }
                        )
                    }
                    .padding()
                    .presentationDragIndicator(.visible)
                    .presentationDetents([.medium])
                    .presentationCornerRadius(30)
                }
                
                HStack {
                    Image(systemName: "lock")
                    Text("Change Password")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .onTapGesture {
                    isChangePasswordSheetOpened = true
                }
                .sheet(isPresented: $isChangePasswordSheetOpened) {
                    VStack(
                        alignment: .leading,
                        spacing: 16
                    ) {
                        
                        Text("Change Password")
                            .fontWeight(.bold)
                            .font(.system(size: 26))
                        
                        HStack {
                            Image(systemName: "lock")
                            SecureField("Enter your current password", text: $currentPassword)
                                .textInputAutocapitalization(.never)
                            if currentPassword.count > 0 {
                                Image(systemName: "multiply")
                                    .onTapGesture {
                                        currentPassword = ""
                                    }
                            }
                        }
                        .padding(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.black, lineWidth: 2)
                        )
                        
                        HStack {
                            Image(systemName: "lock")
                            SecureField("Enter a password", text: $newPassword)
                                .textInputAutocapitalization(.never)
                            if newPassword.count > 0 {
                                Image(systemName: "multiply")
                                    .onTapGesture {
                                        newPassword = ""
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
                                Task {
                                    if let userId = viewModel.currentUser?.id {
                                        viewModel.updateUser(userId: "", email: newEmail)
                                        currentPassword = ""
                                        newPassword = ""
                                        isChangePasswordSheetOpened = false
                                    }
                                }
                            },
                            label: {
                                Text("Change")
                                    .padding(16)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(.white)
                                    .background(.black)
                                    .cornerRadius(30)
                            }
                        )
                        
                    }
                    .padding()
                    .presentationDragIndicator(.visible)
                    .presentationDetents([.medium])
                    .presentationCornerRadius(30)
                }
            }
            .navigationTitle("Profile")
        }
        
        .task {
            viewModel.fetchCurrentUser()
        }
    }
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
    }
}
