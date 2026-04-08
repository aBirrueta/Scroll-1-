//
//  AppView.swift
//  Scroll
//
//  Created by Alejandro Birrueta on 2/20/26.
//

import SwiftUI
import Supabase

struct AppView: View {
    @State var isAuthenticated = false
    
    var body: some View {
        Group {
            if isAuthenticated {
                ProfileCreationView()
            } else {
                TabView {
                    FeedView()
                        .tabItem {
                            Label("Feed", systemImage: "house.fill")
                        }
                    
                    NotificationView()
                        .tabItem {
                            Label("Notifications", systemImage: "bell.fill")
                        }
                    
                    ProfileView()
                        .tabItem {
                            Label("Profile", systemImage: "person.fill")
                        }
                    
                    AuthView()
                }
            }
        }
                .task {
                    for await state in supabase.auth.authStateChanges {
                        if [.initialSession, .signedIn, .signedOut].contains(state.event) {
                            isAuthenticated = state.session != nil
                        }
                    }
                }
        }
    }
    

