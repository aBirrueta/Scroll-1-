//
//  LogInView.swift
//  Scroll
//
//  Created by Alejandro Birrueta on 4/15/26.
//

import Foundation
import Storage
import Supabase
import SwiftUI

struct LogInView: View {
    @State var username = ""
    @State var password: String = ""
    
    var body: some View {
        VStack(spacing: 8){
            TextField("Username", text: $username)
                .textContentType(.username)
                .textInputAutocapitalization(.never)
            SecureField("Enter your password", text: $password)
                .font(.subheadline)
                .padding(12)
                .cornerRadius(10)
                .padding(.horizontal, 24)
            
            Divider()
            
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
        }
    }
}
    #Preview {
        LogInView()
    }
