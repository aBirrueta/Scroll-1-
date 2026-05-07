//
//  ScreentimeApp.swift
//  Screentime
//
//  Created by Alejandro Birrueta on 5/7/26.
//

import SwiftUI
import FamilyControls

@main
struct ScreentimeApp: App {
    var body: some Scene {
        WindowGroup {
         VStack {
           ContentView()
        }.onAppear {
         Task {
           do {
             try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
             print("Authorized")
            } catch {
              print("Error: \(error)")
            }
           }
          }
        }
    }
}
