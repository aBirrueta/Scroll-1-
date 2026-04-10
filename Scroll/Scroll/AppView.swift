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
    @State var hasCompletedProfile = false
    
    var body: some View {
        Group {
            if !isAuthenticated {
                AuthView()
            } else if !hasCompletedProfile {
                ProfileCreationView(onProfileCreated: {
                    hasCompletedProfile = true
                })
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
                }
            }
        }
        .task {
            for await state in supabase.auth.authStateChanges {
                if [.initialSession, .signedIn, .signedOut].contains(state.event) {
                    isAuthenticated = state.session != nil
                    
                    if state.session != nil {
                        await checkProfileStatus()
                    } else {
                        hasCompletedProfile = false
                    }
                }
            }
        }
    }
    
    func checkProfileStatus() async {
        do {
            let currentUser = try await supabase.auth.session.user
            
            let profile: Profile? = try? await supabase
                .from("profiles")
                .select()
                .eq("id", value: currentUser.id)
                .single()
                .execute()
                .value
            
            hasCompletedProfile = profile?.username != nil && !(profile?.username?.isEmpty ?? true)
        } catch {
            hasCompletedProfile = false
        }
    }
}

