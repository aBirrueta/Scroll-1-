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
                Spacer()
            }
            
            Button { } label: {
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
    

#Preview {
    LogInView()
}
