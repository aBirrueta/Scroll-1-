//
//  ProfileView.swift
//  Scroll
//
//  Created by Alejandro Birrueta on 2/20/26.
//

import Storage
import Supabase
import SwiftUI

struct ProfileView: View {
  @State var username = ""
  @State var fullName = ""

  @State var avatarImage: AvatarImage?

  var body: some View {
    NavigationStack {
      Form {
        Section {
          HStack {
            Group {
              if let avatarImage {
                avatarImage.image.resizable()
              } else {
                Color.clear
              }
            }
            .scaledToFit()
            .frame(width: 80, height: 80)
            
            Spacer()
          }
        }
        
        Section {
          TextField("Username", text: $username)
            .textContentType(.username)
            .textInputAutocapitalization(.never)
          TextField("Full name", text: $fullName)
            .textContentType(.name)
        }
      }
      .navigationTitle("Profile")
      .toolbar(content: {
        ToolbarItem {
          Button("Sign out", role: .destructive) {
            Task {
              try? await supabase.auth.signOut()
            }
          }
        }
      })
      .task {
        await getInitialProfile()
      }
    }
  }

  func getInitialProfile() async {
    do {
      let currentUser = try await supabase.auth.session.user

      let profile: Profile =
      try await supabase
        .from("profiles")
        .select()
        .eq("id", value: currentUser.id)
        .single()
        .execute()
        .value

      username = profile.username ?? ""
      fullName = profile.fullName ?? ""
      if let avatarURL = profile.avatarURL, !avatarURL.isEmpty {
        try await downloadImage(path: avatarURL)
      }

    } catch {
      debugPrint(error)
    }
  }

  private func downloadImage(path: String) async throws {
    let data = try await supabase.storage.from("avatars").download(path: path)
    avatarImage = AvatarImage(data: data)
  }
}
