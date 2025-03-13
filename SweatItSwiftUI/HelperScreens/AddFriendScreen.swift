//
//  AddFriendScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 14/03/25.
//

import SwiftUI

struct AddFriendScreen: View {
    var body: some View {
        ScreenBuilder {
           
            AccentPageHeader(pageHeaderTitle: "Add Friend")
            
            ScrollContentView {
                
            }
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        }
    }
}

#Preview {
    AddFriendScreen()
}
