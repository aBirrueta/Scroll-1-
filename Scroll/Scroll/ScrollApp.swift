//
//  ScrollApp.swift
//  Scroll
//
//  Created by Alejandro Birrueta on 2/18/26.
//

import SwiftUI

@main
struct ScrollApp: App {
    @State private var authManager: AuthManager = {
        let service = SupabaseAuthService()
        return AuthManager(service: service)
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(authManager)
        }
        
    }
}
