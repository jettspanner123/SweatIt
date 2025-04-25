//
//  LeaderboardScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 26/03/25.
//

import SwiftUI

struct LeaderboardScreen: View {
    
    @State var users: Array<User_t> = User.current.allUsers.sorted(by: { $0.dailyPoints > $1.dailyPoints })
    var body: some View {
        ScreenBuilder {
            
            AccentPageHeader(pageHeaderTitle: "Leaderboard")
            
            ScrollContentView {
                if GetMethodStore.current.isDatabaseLoading {
                    ProgressView()
                        .tint(.white)
                } else {
                    SectionHeader(text: "Your Score")
                    
                    UserLeaderBoardCard(user: User.current.currentUser, background: ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf, position: -1)
                    
                    SectionHeader(text: "Leaderboard")
                        .padding(.top, 25)
                    
                    ForEach(self.users.indices, id: \.self) { index in
                        let background: LinearGradient = index == 0 ? ApplicationLinearGradient.redGradient : index == 1 ? ApplicationLinearGradient.thanosGradient : index == 2 ? ApplicationLinearGradient.blueGradientInverted : ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf
                        UserLeaderBoardCard(user: self.users[index], background: background, position: index)
                    }
                }
                
            }
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        }
        
    }
}

struct UserLeaderBoardCard: View {
    
    var user: User_t
    var background: LinearGradient
    var position: Int
    
    @State var isRequested: Bool = false
    
    func handleRequest() async throws -> Void {
        let fromUser: User_t = User.current.currentUser
        let toUser: User_t = self.user
        
        try await ApplicationEndpoints.post.createRequest(from: fromUser, to: toUser)
    }
    
    func alreadyRequested() async throws -> Void {
        let fromUserId: String = User.current.currentUser.id
        let toUserId: String = self.user.id
        self.isRequested = try await ApplicationEndpoints.get.hasRequested(from: fromUserId, to: toUserId)
    }
    
    var body: some View {
        HStack(spacing: 15) {
            
            // MARK: User image
            HStack {
                Image(systemName: self.isRequested ? "checkmark" : "person.fill")
                    .foregroundStyle(.white)
            }
            .frame(width: 40, height: 40)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.white.opacity(0.08))
            }
            .background(.white.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
            
            
            
            // MARK: User information
            VStack {
                Text(User.current.currentUser.fullName)
                    .font(.system(size: 13, weight: .medium, design: .rounded))
                    .foregroundStyle(.white)
                    .takeMaxWidthLeading()
                
                Text(User.current.currentUser.username)
                    .font(.system(size: 11, weight: .regular, design: .rounded))
                    .foregroundStyle(.white.opacity(0.5))
                    .takeMaxWidthLeading()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.vertical, 5)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 60)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(.white.opacity(0.08))
        }
        .background(self.background, in: RoundedRectangle(cornerRadius: 12))
        .overlay(alignment: .trailing) {
            HStack {
                Text("\(self.user.dailyPoints)🔥")
                    .font(.system(size: 13, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
            }
            .frame(width: 60, height: 35)
            .overlay {
                Capsule()
                    .stroke(.white.opacity(0.18))
            }
            .background(.white.opacity(0.08), in: Capsule())
            .padding(.horizontal)
            
        }
        
    }
}

#Preview {
    LeaderboardScreen()
}
