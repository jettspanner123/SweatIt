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
            AccentPageHeader(pageHeaderTitle: self.user.username)
            
            ScrollContentView {
                
            }
        }
    }
}

#Preview {
    UserProfileScreen(user: User.current.currentUser)
}
