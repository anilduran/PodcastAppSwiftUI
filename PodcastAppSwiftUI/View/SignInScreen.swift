//
//  LoginScreen.swift
//  PodcastAppSwiftUI
//
//  Created by Anil Duran on 11.06.2023.
//

import SwiftUI

struct SignInScreen: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var isSignedIn = false
    
    @ObservedObject private var viewModel = SignInViewModel()

    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 10
        ) {
            Text("Sign In")
                .fontWeight(.bold)
                .font(.system(size: 26))
            
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
                    .stroke(Color.black, lineWidth: 2)
            )
            
            
            Button(
                action: {
                    viewModel.signIn(email, password) {
                        authManager.isAuthenticated = true
                    }
                },
                label: {
                    Text("Sign In")
                        .padding(16)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color.white)
                        .background(Color.black)
                        .cornerRadius(30)
                }
            )
            .accessibilityIdentifier("SignInButton")
           
            
            
            HStack {
                Text("Do you not have an account?")
                NavigationLink(destination: SignUpScreen()) {
                    Text("Sign Up.")
                }
            }
            
            

            
        }
        .padding()
        
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreen()
    }
}
