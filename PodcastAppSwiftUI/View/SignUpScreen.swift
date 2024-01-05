//
//  RegisterScreen.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 11.06.2023.
//

import SwiftUI

struct SignUpScreen: View {
    
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    
    @ObservedObject private var viewModel = SignUpViewModel()
    
    @EnvironmentObject var authManager: AuthManager

    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 10
        ) {
            
            Text("Sign Up")
                .fontWeight(.bold)
                .font(.system(size: 26))
            
            HStack {
                Image(systemName: "person")
                TextField("Enter a username", text: $username)
                    .textInputAutocapitalization(.never)
                    .accessibilityIdentifier("UsernameTextField")
                if username.count > 0 {
                    Image(systemName: "multiply")
                        .onTapGesture {
                            username = ""
                        }
                }
            }
            .padding(16)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .strokeBorder(Color.black, style: StrokeStyle(lineWidth: 2))
            )
            
            HStack {
                Image(systemName: "envelope")
                TextField("Enter an email", text: $email)
                    .textInputAutocapitalization(.never)
                    .accessibilityIdentifier("EmailTextField")
                if email.count > 0 {
                    Image(systemName: "multiply")
                        .onTapGesture {
                            email = ""
                        }
                }
            }
            .padding(16)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .strokeBorder(Color.black, style: StrokeStyle(lineWidth: 2))
            )
            
            HStack {
                Image(systemName: "lock")
                SecureField("Enter a password", text: $password)
                    .textInputAutocapitalization(.never)
                    .accessibilityIdentifier("PasswordTextField")
                if password.count > 0 {
                    Image(systemName: "multiply")
                        .onTapGesture {
                            password = ""
                        }
                }
            }
            .padding(16)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .strokeBorder(Color.black, style: StrokeStyle(lineWidth: 2))
            )
  
            Button(
                action: {
                    viewModel.signUp(username, email, password) {
                        authManager.isAuthenticated = true
                    }
                },
                label: {
                    Text("Sign Up")
                        .padding(16)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .cornerRadius(30)
                }
            )
            .accessibilityIdentifier("SignUpButton")
            
            
            HStack {
                Text("Do you have an account?")
                NavigationLink(destination: SignInScreen()) {
                    Text("Sign In.")
                }
            }
            
            
        }
        .padding()
       
    }
}

struct RegisterScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreen()
    }
}
