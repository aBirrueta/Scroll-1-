//
//  ProfileCreationView.swift
//  Scroll
//
//  Created by Alejandro Birrueta on 4/8/26.
//


import SwiftUI

struct ProfileCreationView: View {
    @Environment(AuthManager.self) private var authmanager
    @Environment(\.dismiss) private var dismiss
    
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    @State private var confirmedPassword = ""
    @State private var passwordsMatch = false
    
    var body: some View {
        VStack(spacing: 8){
            Spacer()
            
            TextField("Enter your email", text: $email)
                .autocapitalization(.none)
                .font(.subheadline)
                .padding(12)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal,24)
            
            TextField("Enter your username", text: $username)
                .autocapitalization(.none)
                .font(.subheadline)
                .padding(12)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal,24)
            
            ZStack(alignment: .trailing){
                SecureField("Enter your password", text: $password)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                
                if !password.isEmpty && !confirmedPassword.isEmpty {
                    Image(systemName: passwordsMatch ? "checkmark.circle.fill" : "xmark.crircle.fill")
                        .foregroundStyle(passwordsMatch ? .green : .red)
                        .padding(.horizontal)
                }
            }
            .padding(.horizontal, 24)
            .onChange(of: confirmedPassword){ oldValue, newValue in
                passwordsMatch = newValue == password
            }
        }
            
            ZStack(alignment: .trailing){
                SecureField("Confirm your password", text: $password)
                    .font(.subheadline)
                    .padding(12)
                    .background (Color(.systemGray6))
                    .cornerRadius(10)
                if !password.isEmpty && !confirmedPassword.isEmpty {
                    Image(systemName: passwordsMatch ? "checkmark.circle.fill" : "xmark.crircle.fill")
                        .foregroundStyle(passwordsMatch ? .green : .red)
                        .padding(.horizontal)
                }
            }
            
            Button { } label: {
                Text("Sign up")
                    .frame(width: 360, height: 48) .font(.headline)
                    .background(.blue)
                    .cornerRadius (8)
                    .foregroundStyle(.white)
            }
            .padding(.vertical)
            
            Spacer ()
            
            Divider ()
            
            Button { dismiss() } label: {
                HStack(spacing: 3) {
                    Text("Already have an account?")
                    
                    Text("Sign in")
                        .fontWeight(.semibold)
                }
                .font(.subheadline)
            }
            .padding(.vertical,16)
        }
    }

private extension ProfileCreationView {
    func signUp() {
        Task {
            await authManager.signUp(
                withEmail: email,
                password: password
            )
        }
    }
}
#Preview {
    ProfileCreationView()
}

