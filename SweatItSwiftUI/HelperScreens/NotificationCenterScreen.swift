//
//  NotificationCenterScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 14/03/25.
//

import SwiftUI

let SCROLL_CONSTANT: CGFloat = 20

struct NotificationCenterScreen: View {
    
    @Binding var showNotificationCenter: Bool
    
    @State var pageTranslation: CGSize = .zero
    
    @State var notification: Array<Notification_t> = Notification.current.notifications
    
    var body: some View {
        ZStack(alignment: .top) {
            
            
            // MARK: Page heading
            HStack {
                
                Text("Notifications")
                    .font(.system(size: 25, weight: .light, design: .rounded))
                    .foregroundStyle(.white)
                
            }
            .frame(maxWidth: .infinity)
            .overlay {
                HStack {
                    Image(systemName: "xmark")
                        .foregroundStyle(.white)
                        .padding()
                        .background(.white.opacity(0.001))
                        .onTapGesture {
                            withAnimation {
                                self.showNotificationCenter = false
                            }
                        }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding + 5)
            }
            .padding(.top, ApplicationPadding.mainScreenVerticalPadding - SCROLL_CONSTANT)
            .padding(.bottom, 20)
            .background(
                HStack {
                    
                }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(AppBackgroundBlur(radius: 10, opaque: false))
            )
            
            .zIndex(11)
            
            
            // MARK: Scroll content View
            ScrollView(.vertical, showsIndicators: false) {
                
                
                // MARK: Vertical stack
                VStack {
                    
                    OngoingWorkoutView()
                    
                    SectionHeader(text: "Friend Requests")
                        .padding(.top, 20)
                    ForEach(self.notification, id: \.id) { notification in
                        if notification.notificationType == .friendRequest {
                            NotificationCard(notification: notification)
                        }
                    }
                    
                }
                .padding(.vertical, ApplicationPadding.mainScreenVerticalPadding + (SCROLL_CONSTANT * 2) + 10)
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                
            }
            
        }
        .frame(maxWidth: .infinity)
        .background(AppBackgroundBlur(radius: 100, opaque: true))
        .background(.darkBG.opacity(0.54))
        .ignoresSafeArea()
        .offset(y: self.pageTranslation.height)
        .gesture(
            DragGesture()
                .onChanged { value in
                    if value.translation.height > .zero {
                        withAnimation(.bouncy) {
                            self.pageTranslation = value.translation
                        }
                    }
                }
                .onEnded { value in
                    if value.translation.height > 150 {
                        withAnimation(.smooth) {
                            self.showNotificationCenter = false
                        }
                        
                        DispatchQueue.main
                            .asyncAfter(deadline: .now() + 0.4, execute: {
                                self.pageTranslation = .zero
                            })
                    } else {
                        withAnimation(.smooth) {
                            self.pageTranslation = .zero
                        }
                    }
                }
        )
    }
}

struct NotificationCard: View {
    var notification: Notification_t
    
    var body: some View {
        if let friendRequest = self.notification.notificationAction as? FriendRequest_t {
            FriendRequestCard(notification: friendRequest)
        }
        
    }
}

struct FriendRequestCard: View {
    
    var notification: FriendRequest_t
    var userFrom: User_t? = nil
    
    var body: some View {
        VStack(spacing: 10) {
            
            // MARK: Photo and the name of the sender
            HStack {
                RoundedRectangle(cornerRadius: 17)
                    .fill(ApplicationLinearGradient.redGradient)
                    .frame(width: 80, height: 80)
                
                VStack {
                    
                    
                    // MARK: Name of the shit
                    Text(self.notification.fromUser.username)
                        .font(.system(size: 15, weight: .regular, design: .rounded))
                        .foregroundStyle(.white)
                        .takeMaxWidthLeading()
                    
                    
                    Text("Want's to be friends with you !")
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundStyle(.white.opacity(0.5))
                        .takeMaxWidthLeading()
                    
                    Spacer()
                    
                    Text(String(self.notification.toUserId.dailyPoints) + "🔥")
                        .font(.system(size: 15, weight: .regular, design: .rounded))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 5)
                        .background(.darkBG)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.white.opacity(0.18))
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    

                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.top, 5)
            }
            
            
            
            // MARK: Accept and reject butons
            
            HStack {
                Text("Accept")
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundStyle(.white.opacity(0.75))
            }
            .frame(maxWidth: .infinity)
            .frame(height: 40)
            .background(ApplicationLinearGradient.greenGradient)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.top, 10)
            
            
            HStack {
                Text("Reject")
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundStyle(.white.opacity(0.75))
            }
            .frame(maxWidth: .infinity)
            .frame(height: 40)
            .background(ApplicationLinearGradient.redGradient)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding()
        .background(.darkBG)
        .overlay {
            defaultShape
                .stroke(.white.opacity(0.18))
        }
        .clipShape(defaultShape)
    }
}

struct OngoingWorkoutView: View {
    var body: some View {
        HStack {
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .background(ApplicationLinearGradient.redGradient)
        .clipShape(defaultShape)
    }
}
