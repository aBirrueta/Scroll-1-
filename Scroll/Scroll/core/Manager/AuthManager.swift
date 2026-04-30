//
//  AuthManager.swift
//  Scroll
//
//  Created by Alejandro Birrueta on 4/30/26.
//

import Foundation

@Observable @MainActor
final class AuthManager {
    private let service: SupabaseAuthService
    
    var error: Error?
    var authState: AuthenticationState = .notDetermined
    
    init(service: SupabaseAuthService) {
        self.service = service
    }
    
    func login(withEmail email: String, password: String) async {
        do {
            self.authState = try await service.login(withEmail: email, password: password)
        } catch {
            self.error = error
            print("DEBUG: Error logging in: \(error)")
        }
    }
    
    func signUp(withEmail email: String, password: String) async {
        do {
            self.authState = try await service.signUp(withEmail: email, password: password)
        } catch {
            print("DEBUG: Error Signing up: \(error)")
        }
    }
    
    func signOut() async {
        do{
            try await service.signOut()
        } catch{
            print("DEBUG: Error Signing out: \(error)")
        }
    }
    
    func getAuthState() async {
        do{
            self.authState = try await service.getAuthState()
        } catch{
            print("DEBUG: Error Signing out: \(error)")
        }
    }
}
