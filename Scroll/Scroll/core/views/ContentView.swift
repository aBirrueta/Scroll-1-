//
//  ContentView.swift
//  Scroll
//
//  Created by Alejandro Birrueta on 4/30/26.
//

import SwiftUI

struct ContentView: View {
    @Environment(AuthManager.self) private var authManager
    
    var body: some View {
        Group{
            switch authManager.authstate {
            case .notDetermined:
                ProgressView()
            case .notAuthenticated:
                LogInView()
            case .authenticated:
                VStack{
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Button("Sign Out"){
                        Task { await authManager.signOut() }
                    }
                }
                .padding()
                
            }
        }
        .task { await auth}
    }
}
 
#Preview {
    ContentView()
}
