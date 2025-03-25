//
//  ProfileScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 14/03/25.
//

import SwiftUI

struct ProfileScreen: View {
    
    @Binding var user: User_t
    
    
    @State var showPastStatisticsScreen: Bool = true
    @State var showAddFriendScreen: Bool = false
    
    var body: some View {
        ScrollContentView {
            
            HStack(spacing: 10) {
                
                
                // MARK: Profile icon
                HStack {
                    
                }
                .frame(width: 100, height: 100)
                .background(ApplicationLinearGradient.blueGradient)
                .clipShape(defaultShape)
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
                    HStack(spacing: 15) {
                        Image(systemName: "person.badge.plus")
                            .foregroundStyle(.white.opacity(0.5))
                        Text("Add Fiend")
                            .font(.system(size: 13, weight: .medium, design: .rounded))
                            .foregroundStyle(.white.opacity(0.5))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 40)
                    .padding(.horizontal, 15)
                    .background(ApplicationLinearGradient.redGradient)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay {
                        HStack {
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.white.opacity(0.5))
                                .scaleEffect(0.55)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.horizontal, 15)
                    }
                    .onTapGesture {
                        self.showAddFriendScreen = true
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
                HStack(spacing: 15) {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.white.opacity(0.5))
                    
                    Text("User Details")
                        .font(.system(size: 15, weight: .regular, design: .rounded))
                        .foregroundStyle(.white.opacity(0.5))
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .scaleEffect(0.75)
                        .foregroundStyle(.white.opacity(0.5))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.vertical, 3)
                
                CustomDivider()
                
                HStack(spacing: 15) {
                    Image(systemName: "bell.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.white.opacity(0.5))
                    
                    Text("Notifications")
                        .font(.system(size: 15, weight: .regular, design: .rounded))
                        .foregroundStyle(.white.opacity(0.5))
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .scaleEffect(0.75)
                        .foregroundStyle(.white.opacity(0.5))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.vertical, 3)
                
                CustomDivider()
                
                HStack(spacing: 15) {
                    Image(systemName: "hand.thumbsup.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.white.opacity(0.5))
                    
                    Text("Recommendations")
                        .font(.system(size: 15, weight: .regular, design: .rounded))
                        .foregroundStyle(.white.opacity(0.5))
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .scaleEffect(0.75)
                        .foregroundStyle(.white.opacity(0.5))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.vertical, 3)
            }
            .padding(.top, 20)
            
            
            
            
            // MARK: Past stats
            
            HeadingWithLink(titleHeading: "Past Statistics") {
                self.showPastStatisticsScreen = true
            }
            .padding(.top, 20)
            
            
            
            
            // MARK: Steps graph card
            HStack {
                
                VStack {
                    
                    // MARK: Heading
                    Text("Avg Step Count")
                        .font(.custom(ApplicationFonts.oswaldRegular, size: 20))
                        .foregroundStyle(.white)
                        .takeMaxWidthLeading()
                    
                    Text("(this month)")
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundStyle(.white.opacity(0.5))
                        .takeMaxWidthLeading()
                        
                    
                    Spacer()
                    // MARK: Step count
                    Text("\(13900)")
                        .font(.custom(ApplicationFonts.oswaldSemiBold, size: 40))
                        .foregroundStyle(.white.opacity(0.5))
                        .takeMaxWidthLeading()
                        .offset(x: -3, y: 5)
                    
                    
                    Text("steps")
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundStyle(.white.opacity(0.5))
                        .takeMaxWidthLeading()
                    
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                
                
                HStack {
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .frame(height: 200, alignment: .topLeading)
            .padding()
            .background(ApplicationLinearGradient.blueGradient)
            .clipShape(defaultShape)
            
            
            HeadingWithLink(titleHeading: "Top Performers")
                .padding(.top, 20)
            
        }
        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        .navigationDestination(isPresented: self.$showPastStatisticsScreen, destination: {
            PastStatisticsScreen()
        })
        .navigationDestination(isPresented: self.$showAddFriendScreen, destination: {
            AddFriendScreen()
        })
    }
}
