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
        .clipped()
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
//            FriendRequestCard(notification: friendRequest)
        }
        
    }
}



