//
//  ProfileScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 14/03/25.
//

import SwiftUI

struct ProfileScreen: View {
    
    @Binding var user: User_t
    var profileViewText: String {
        return self.user.fullName.split(separator: " ").map { String($0.first!) }.joined()
    }
    
    @State var showPastStatisticsScreen: Bool = false
    @State var showAddFriendScreen: Bool = false
    @State var showLeaderboardScreen: Bool = false
    
//    @State var allUsers: Array<User_t> = User.current.users
    @State var allUsers: Array<User_t> = User.current.allUsers.sorted(by: { $0.dailyPoints > $1.dailyPoints })
    
    var body: some View {
        ScrollContentView {
            
            HStack(spacing: 10) {
                
                
                // MARK: Profile icon
                HStack {
                    Text(self.profileViewText)
                        .font(.custom(ApplicationFonts.oswaldRegular, size: 35))
                        .foregroundStyle(.white)
                }
                .frame(width: 100, height: 100)
                .background(ApplicationLinearGradient.blueGradient, in: RoundedRectangle(cornerRadius: 12))
                //                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                // MARK: User profile
                
                VStack {
                    Text(self.user.fullName)
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundStyle(.white)
                        .takeMaxWidthLeading()
                    
                    Text(self.user.username)
                        .font(.system(size: 13, weight: .regular, design: .rounded))
                        .foregroundStyle(.white.opacity(0.5))
                        .takeMaxWidthLeading()
                    
                    
                    
                    Spacer()
                    
                    
                    // MARK: Add friend button
                    NavigationLink(destination: AddFriendScreen()) {
                        HStack(spacing: 15) {
                            Image(systemName: "person.badge.plus")
                                .foregroundStyle(.white)
                                .offset(y: 2)
                            Text("Add Fiend")
                                .font(.custom(ApplicationFonts.oswaldRegular, size: 13))
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.white)
                                .scaleEffect(0.65)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 40)
                        .padding(.horizontal, 15)
                        .background(ApplicationLinearGradient.redGradient, in: RoundedRectangle(cornerRadius: 8))
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.top, 8)
                .overlay {
                    HStack {
                        
                        
                        // MARK: Points earned by user
                        HStack(spacing: 5) {
                            Text("\(self.user.dailyPoints)")
                                .font(.custom(ApplicationFonts.oswaldRegular, size: 20))
                                .foregroundStyle(.white)
                            
                            Text("🔥")
                                .font(.system(size: 20))
                        }
                        .frame(height: 40)
                        .padding(.horizontal, 15)
                        .background(.darkBG.opacity(0.54))
                        .background(AppBackgroundBlur(radius: 100, opaque: true))
                        .overlay {
                            defaultShape
                                .stroke(.white.opacity(0.18))
                        }
                        .clipShape(defaultShape)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .padding(.top, 8)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // MARK: Settins
            
            CustomList {
                
                // MARK: User details settings
                NavigationLink(destination: UserDetailsPage()) {
                    CustomListNavigationButton(image: "person.fill", name: "User Details")
                }
                
                
                CustomDivider()
                
                NavigationLink(destination: ManageNotificationScreen()) {
                    CustomListNavigationButton(image: "bell.fill", name: "Notifications")
                }
                
                CustomDivider()
                
                NavigationLink(destination: EmptyView()) {
                    CustomListNavigationButton(image: "hand.thumbsup.fill", name: "Recommendations")
                }
            }
            .padding(.top, 20)
            
            
            
            
            // MARK: Past stats
            
            HeadingWithLink(titleHeading: "Past Statistics") {
                self.showPastStatisticsScreen = true
            }
            .padding(.top, 20)
            
            
            
            
            //             MARK: Steps graph card
            AvgStepsThisWeekGraph()
            
            
            
            
            
            HeadingWithLink(titleHeading: "Top Performers", action: {
                self.showLeaderboardScreen = true
            })
            .padding(.top, 20)
            
            ForEach(self.allUsers.prefix(3).indices, id: \.self) { index in
                let user = self.allUsers[index]
                
                let background = index == 0 ? ApplicationLinearGradient.redGradient : index == 1 ? ApplicationLinearGradient.thanosGradient : ApplicationLinearGradient.blueGradient
                UserLeaderBoardCard(user: user, background: background, position: index)
            }
            
            
            
        }
        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        .navigationDestination(isPresented: self.$showPastStatisticsScreen, destination: {
            PastStatisticsScreen()
        })
        .navigationDestination(isPresented: self.$showAddFriendScreen, destination: {
            AddFriendScreen()
        })
        .navigationDestination(isPresented: self.$showLeaderboardScreen, destination: {
            LeaderboardScreen()
        })
    }
}




