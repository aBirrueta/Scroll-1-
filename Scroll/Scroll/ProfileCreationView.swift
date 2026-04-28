//
//  ProfileCreationView.swift
//  Scroll
//
//  Created by Alejandro Birrueta on 4/8/26.
//


import PhotosUI
import Storage
import Supabase
import SwiftUI

struct ProfileCreationView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    @State private var confirmedPassword = ""
    @State private var passwordsMatch = false
  var onProfileCreated: () -> Void

  var body: some View {
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
          TextField("Enter your username", text: $username)
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

        Section {
          Button("Create profile") {
            updateProfileButtonTapped()
          }
          .bold()

          if isLoading {
            ProgressView()
          }
        }
      }
      .navigationTitle("Profile Creation")
      .toolbar(content: {
        ToolbarItem {
          Button("Sign out", role: .destructive) {
            Task {
              try? await supabase.auth.signOut()
            }
          }
        }
      })
      .onChange(of: imageSelection) { _, newValue in
        guard let newValue else { return }
        loadTransferable(from: newValue)
      }
    }
    .task {
      await getInitialProfile()
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

  func updateProfileButtonTapped() {
    Task {
      isLoading = true
      defer { isLoading = false }
      do {
        let imageURL = try await uploadImage()

        let currentUser = try await supabase.auth.session.user

        let updatedProfile = Profile(
          username: username,
          fullName: fullName,
          avatarURL: imageURL
        )

        try await supabase
          .from("profiles")
          .update(updatedProfile)
          .eq("id", value: currentUser.id)
          .execute()
        
        onProfileCreated()
        
      } catch {
        debugPrint(error)
      }
    }
  }

  private func loadTransferable(from imageSelection: PhotosPickerItem) {
    Task {
      do {
        avatarImage = try await imageSelection.loadTransferable(type: AvatarImage.self)
      } catch {
        debugPrint(error)
      }
    }
  }

  private func downloadImage(path: String) async throws {
    let data = try await supabase.storage.from("avatars").download(path: path)
    avatarImage = AvatarImage(data: data)
  }

  private func uploadImage() async throws -> String? {
    guard let data = avatarImage?.data else { return nil }

    let filePath = "\(UUID().uuidString).jpeg"

    try await supabase.storage
      .from("avatars")
      .upload(
        filePath,
        data: data,
        options: FileOptions(contentType: "image/jpeg")
      )

    return filePath
  }
}
