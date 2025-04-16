//
//  AddFriendScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 14/03/25.
//

import SwiftUI

struct AddFriendScreen: View {
    @State var searchText: String = ""
    @State var allUsers: Array<User_t> = []
    
    var body: some View {
        ScreenBuilder {
           
            AccentPageHeader(pageHeaderTitle: "Add Friend")
            
            ScrollContentView {
                if GetMethodStore.current.isDatabaseLoading {
                    ProgressView()
                        .tint(.white)
                } else {
                    CustomTextField(searchText: self.$searchText, placeholder: "Search Username")
                    
                    SectionHeader(text: "All Users")
                        .padding(.top, 25)
                    
                    ForEach(self.allUsers, id: \.id) { user in
                        NavigationLink(destination: UserProfileScreen(user: user)) {
                            AddUserCard(user: user)
                        }
                    }
                }
            }
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        }
        .onAppear {
            
            if let cachedUserData = UserDefaults.standard.data(forKey: getCacheValue(for: .cacheForAddFriendsPage)), let cachedUsers = try? JSONDecoder().decode([User_t].self, from: cachedUserData) {
                self.allUsers = cachedUsers
            }
            
            Task {
                self.allUsers = try await ApplicationEndpoints.get.fetchAllUsersFromDatabase()
                
                if let encoder = try? JSONEncoder().encode(self.allUsers) {
                    UserDefaults.standard.set(encoder, forKey: getCacheValue(for: .cacheForAddFriendsPage))
                }
            }
        }
    }
}


struct AddUserCard: View {
    var user: User_t
    var body: some View {
        HStack {
            
            
            // MARK: Profile icon
            HStack {
                Image(systemName: "person.fill")
                    .foregroundStyle(.white.opacity(0.5))
            }
            .frame(width: 60, height: 60)
            .background(.white.opacity(0.18), in: Circle())
            .padding(.horizontal)
            
            
            
            // MARK: Details
            
            VStack {
                Text(self.user.fullName)
                    .font(.system(size: 13, weight: .medium, design: .rounded))
                    .foregroundStyle(.white.opacity(0.75))
                    .takeMaxWidthLeading()

                Text(self.user.username)
                    .font(.system(size: 11, weight: .regular, design: .rounded))
                    .foregroundStyle(.white.opacity(0.5))
                    .takeMaxWidthLeading()
                
                Spacer()
                
                Text("\(self.user.dailyPoints)🔥")
                    .font(.system(size: 11, weight: .regular, design: .rounded))
                    .foregroundStyle(.white.opacity(0.5))
                    .takeMaxWidthLeading()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.vertical, 15)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 80)
        .overlay {
            defaultShape
                .stroke(.white.opacity(0.08))
        }
        .background(.darkBG.opacity(0.54), in: defaultShape)
        .overlay(alignment: .trailing) {
            HStack {
                HStack {
                    Image(systemName: "person.fill.badge.plus")
                        .foregroundStyle(.white)
                }
                .frame(width: 60, height: 35)
                .background(ApplicationLinearGradient.redGradient, in: Capsule())
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.white.opacity(0.5))
                    .scaleEffect(0.75)
            }
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        }
    }
}

#Preview {
    AddFriendScreen()
}
