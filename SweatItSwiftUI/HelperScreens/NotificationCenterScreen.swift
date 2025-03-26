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
    
    let chestWorkout = Workout.current.chestWorkout

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
                    .padding(.top, -15)
                    .padding(.horizontal, -15)
                    .padding(.bottom, 15)
            )
            
            .zIndex(11)
            
            
            // MARK: Scroll content View
            ScrollView(.vertical, showsIndicators: false) {
                
                
                // MARK: Vertical stack
                VStack {
                    
//                    OngoingWorkoutView()
                    SectionHeader(text: "Ongoing Workout")
                    
                    
                    NavigationLink(destination: ActiveWorkoutScreen(workout: self.chestWorkout)) {
                        WorkoutCard(image: chestWorkout.workoutImage, name: chestWorkout.workoutName, difficulty: chestWorkout.workoutDifficulty, sideOffset: 50, isViewCard: true)
                    }
                    
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
        VStack(spacing: 15) {
            
            // MARK: Photo and the name of the sender
            HStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(ApplicationLinearGradient.redGradient)
                    .frame(width: 80, height: 80)
                    .overlay {
                        Image(systemName: "person.fill")
                            .foregroundStyle(.white.opacity(0.5))
                            .scaleEffect(2)
                    }
                
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
//                        .font(.system(size: 15, weight: .regular, design: .rounded))
                        .font(.custom(ApplicationFonts.oswaldRegular, size: 15))
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
            .background(ApplicationLinearGradient.greenGradient.opacity(0.5))
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.white.opacity(0.18))
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.top, 10)
            
            
            HStack {
                Text("Reject")
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundStyle(.white.opacity(0.75))
            }
            .frame(maxWidth: .infinity)
            .frame(height: 40)
            .background(ApplicationLinearGradient.bloodRedGradient.opacity(0.5))
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.white.opacity(0.18))
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding()
        .background(ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf)
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
            
            
            
            
            // MARK: Image view
            HStack {
                Image("Dumbbell")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .rotationEffect(.degrees(-30))
            }
            .frame(width: 100)
            .frame(maxHeight: .infinity)
            .background(.white.opacity(0.08))
            
            
            
            // MARK: Content view
            
            VStack {
                
                
                
                // MARK: ONgoing workout text
                HStack {
                    Text("Ongoing Workout: ")
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundStyle(.white.opacity(0.75))
                    
                    Text("Chest Workout")
                        .font(.system(size: 10, weight: .regular, design: .rounded))
                        .foregroundStyle(.white.opacity(0.5))
                }
                .frame(maxWidth: .infinity, alignment: .bottomLeading)
                
                
                Spacer()
                
                // MARK: WOrkout information
                HStack {
                    
                    // MARK: Current calories burned
                    HStack(spacing: 5) {
                        Text("100")
                            .font(.custom(ApplicationFonts.oswaldRegular, size: 20))
                            .foregroundStyle(.white)
                        
                        Text("🔥")
                            .font(.system(size: 20))
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 8)
                    .background(.darkBG.opacity(0.54))
                    .background(AppBackgroundBlur(radius: 100, opaque: true))
                    .overlay {
                        defaultShape
                            .stroke(.white.opacity(0.18))
                    }
                    .clipShape(defaultShape)
                    
                    // MARK: Current workout timing
                    HStack(spacing: 5) {
                        Text("17.5")
                            .font(.custom(ApplicationFonts.oswaldRegular, size: 20))
                            .foregroundStyle(.white)
                        
                        Text("⏰")
                            .font(.system(size: 20))
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 8)
                    .background(.darkBG.opacity(0.54))
                    .background(AppBackgroundBlur(radius: 100, opaque: true))
                    .overlay {
                        defaultShape
                            .stroke(.white.opacity(0.18))
                    }
                    .clipShape(defaultShape)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(8)
            .padding(.vertical, 5)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 100)
        .background(ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf)
        .overlay {
            defaultShape
                .stroke(.white.opacity(0.18))
        }
        .clipShape(defaultShape)
    }
}
