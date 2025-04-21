//
//  UserProfileScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 16/04/25.
//

import SwiftUI

struct UserProfileScreen: View {
    var user: User_t
    var body: some View {
        ScreenBuilder {
            
            let accentPageHeaderText: String = String(self.user.fullName.split(separator: " ").first!)
            AccentPageHeader(pageHeaderTitle: "\(accentPageHeaderText)'s Profile")
            
            ScrollContentView {
                
            }
        }
    }
}

#Preview {
    UserProfileScreen(user: User.current.currentUser)
}
