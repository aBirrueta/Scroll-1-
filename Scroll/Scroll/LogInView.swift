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

struct Log`: View {
    @State var username = ""
    var body: some View {
        TextField("Username", text: $username)
          .textContentType(.username)
          .textInputAutocapitalization(.never)
    }
    
}

