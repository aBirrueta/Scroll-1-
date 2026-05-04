//
//  LogInView.swift
//  Scroll
//
//  Created by Alejandro Birrueta on 4/15/26.
//

import SwiftUI

struct LogInView: View {
    @Environment(AuthManager.self) private var authmanager
    
    @State var email = ""
    @State var password: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 8){
                Spacer()
                TextField("Enter your email", text: $email)
                    .autocapitalization(.none)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal,
                             24)
                
                SecureField("Enter your password", text: $password)
                    .font(.subheadline)
                    .padding(12)
                    .background (Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            
            Button { signIn() } label: {
                Text( "Login")
                    .frame(width: 360, height: 48) .font(.headline)
                    .background(.blue)
                    .cornerRadius (8)
                    .foregroundStyle(.white)
            }
            .padding(.vertical)
            
            
            Spacer ()
            
            Divider ()
            
            
            NavigationLink{
                ProfileCreationView()
                    .navigationBarBackButtonHidden()
            } label: {
                HStack(spacing: 3){
                    Text("Dont have an account?")
                    
                    Text("Sign up")
                        .fontWeight(.semibold)
                }
                .font(.subheadline)
            }
            .padding(.vertical,16)
        }
    }
}

private extension LogInView {
    func signIn() {
        Task {
            await authmanager.login(withEmail: email, password: password)
        }
    }
}

#Preview {
    LogInView()
}
