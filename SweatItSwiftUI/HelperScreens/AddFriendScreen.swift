//
//  AddFriendScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 14/03/25.
//

import SwiftUI

struct AddFriendScreen: View {
    
    enum FriendsDisplayOption: String {
        case allUsers, friends
    }
    
    @State var currentSelectedUserFriendsState: FriendsDisplayOption = .allUsers
    @State var searchText: String = ""
    @State var allUsers: Array<User_t> = []
    @State var allRequests: Array<FriendRequest_t> = []
    
    @State var filteredUsers: Array<User_t> = []
        
    
    
    func onSearchTextChange() -> Void {
        self.filteredUsers = self.allUsers.filter { $0.username.lowercased().starts(with: self.searchText) || $0.username.starts(with: self.searchText) }
    }
    
    var body: some View {
        ScreenBuilder {
           
            AccentPageHeader(pageHeaderTitle: "Add Friend")
            
            ScrollContentView {
                if GetMethodStore.current.isDatabaseLoading {
                    ProgressView()
                        .tint(.white)
                } else {
                    CustomTextField(searchText: self.$searchText, placeholder: "Search Username")
                        .autocapitalization(.none)
                    
                    if self.searchText.isEmpty {
                        
                        // MARK: DUal action sort button ( all users and freidns )
                        HStack {
                            HStack {
                                Image(systemName: "person.3.fill")
                                    .foregroundStyle(self.currentSelectedUserFriendsState == .allUsers ? .white : .white.opacity(0.5))
                                
                                Text("All Users")
                                    .font(.system(size: 13, weight: .medium, design: .rounded))
                                    .foregroundStyle(self.currentSelectedUserFriendsState == .allUsers ? .white : .white.opacity(0.5))
                            }
                            .applicationDropDownButton(self.currentSelectedUserFriendsState == .allUsers ? ApplicationLinearGradient.blueGradientInverted : ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf, height: 40)
                            .onTapWithScaleVibrate(scaleBy: 0.75) {
                                withAnimation {
                                    self.currentSelectedUserFriendsState = .allUsers
                                }
                            }
                            
                            
                            HStack {
                                Image(systemName: "person.fill")
                                    .foregroundStyle(self.currentSelectedUserFriendsState == .friends ? .white : .white.opacity(0.5))
                                
                                Text("Friends")
                                    .font(.system(size: 13, weight: .medium, design: .rounded))
                                    .foregroundStyle(self.currentSelectedUserFriendsState == .friends ? .white : .white.opacity(0.5))
                            }
                            .applicationDropDownButton(self.currentSelectedUserFriendsState == .friends ? ApplicationLinearGradient.blueGradientInverted : ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf, height: 40)
                            .onTapWithScaleVibrate(scaleBy: 0.75) {
                                withAnimation {
                                    self.currentSelectedUserFriendsState = .friends
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        
                        
                        
                        if self.currentSelectedUserFriendsState == .allUsers {
                            VStack {
                                SectionHeader(text: "All Users")
                                    .padding(.top, 25)
                                
                                ForEach(self.allUsers, id: \.id) { user in
                                    if user.id != User.current.currentUser.id {
                                        NavigationLink(destination: UserProfileScreen(user: user)) {
                                            AddUserCard(user: user)
                                        }
                                    }
                                }
                            }
                            .transition(.offset(y: UIScreen.main.bounds.height))
                        } else {
                            VStack {
                                SectionHeader(text: "All Friends")
                                    .padding(.top, 25)
                            }
                            .transition(.offset(y: UIScreen.main.bounds.height))

                        }
                        
                        
                        
                        
                        
                    } else {
                        SectionHeader(text: "Search Reasults for \(self.searchText)...")
                            .padding(.top, 25)
                        
                        ForEach(self.filteredUsers, id: \.id) { user in
                            if user.id != User.current.currentUser.id {
                                NavigationLink(destination: UserProfileScreen(user: user)) {
                                    AddUserCard(user: user)
                                }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        }
        .onChange(of: self.searchText) {
            self.onSearchTextChange()
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


#Preview {
    AddFriendScreen()
}
