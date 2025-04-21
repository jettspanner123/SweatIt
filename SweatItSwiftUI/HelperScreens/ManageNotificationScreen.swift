//
//  ManageNotificationScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 21/04/25.
//

import SwiftUI

struct ManageNotificationScreen: View {
    
    
    enum NotificationTab: String, CaseIterable {
        case personal, friends, challenges, application
    }
    
    @State var showNotifications: Bool = true
    @State var showNotificationOptions: Bool = true
    @State var showPushNotifications: Bool = true
    @State var currentSelectedTab: NotificationTab = .personal
    @State var currentSelectedNotificationType: Extras.GlobalNotificationType = .sounded
    
    var body: some View {
        ScreenBuilder {
            
            AccentPageHeader(pageHeaderTitle: "Notifications")
                
            ScrollContentView {
                
                // MARK: Show all notifications thing
                SectionHeader(text: "Global Notification Settings")
                    
                CustomList {
                    Toggle(isOn: self.$showNotifications) {
                        Text("Show In-App Notification")
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                            .foregroundStyle(.white)
                        Text("Notification that will be shown in the applicaiton itself")
                            .font(.system(size: 10, weight: .medium, design: .rounded))
                            .foregroundStyle(.white.opacity(0.5))
                        
                    }
                    .tint(ApplicationLinearGradient.blueGradientInverted)
                    .padding(.horizontal)
                    .padding(.top, 5)

                    
                    // MARK: If show notification type
                    if self.showNotificationOptions {
                        HStack {
                            ForEach(Extras.GlobalNotificationType.allCases, id: \.self) { type in
                                HStack {
                                    Text(type.rawValue.capitalized)
                                        .font(.system(size: 13, weight: .medium, design: .rounded))
                                        .foregroundStyle(self.currentSelectedNotificationType == type ? .white : .white.opacity(0.5))
                                        .frame(maxWidth: .infinity)
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 35)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(.white.opacity(0.08))
                                }
                                .background(self.currentSelectedNotificationType == type ? ApplicationLinearGradient.blueGradientInverted : ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf, in: RoundedRectangle(cornerRadius: 12))
                                .onTapWithScaleVibrate(scaleBy: 0.75) {
                                    withAnimation {
                                        self.currentSelectedNotificationType = type
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .transition(.blurReplace.combined(with: .scale.combined(with: .opacity)))
                    }

                    CustomDivider()
                    
                    Toggle(isOn: self.$showPushNotifications) {
                        Text("Show Push Notification")
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                            .foregroundStyle(.white)
                        Text("Notification that will be shown external of the application. (Notification Center) etc.")
                            .font(.system(size: 10, weight: .medium, design: .rounded))
                            .foregroundStyle(.white.opacity(0.5))
                    }
                    .tint(ApplicationLinearGradient.blueGradientInverted)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                }
               
                
                
                
                SectionHeader(text: "Notification Settings")
                    .padding(.top, 25)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(NotificationTab.allCases, id: \.self) { tab in
                            HStack {
                                Text(tab.rawValue.capitalized)
                                    .font(.system(size: 13, weight: .medium, design: .rounded))
                                    .foregroundStyle(self.currentSelectedTab == tab ? .white : .white.opacity(0.5))
                            }
                            .applicationDropDownButton(self.currentSelectedTab == tab ? ApplicationLinearGradient.blueGradientInverted : ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf)
                            .onTapWithScaleVibrate(scaleBy: 0.75) {
                                withAnimation {
                                    self.currentSelectedTab = tab
                                }
                            }
                        }
                    }
                }
                
                
                
                
                
            }
            .safeAreaPadding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        }
        .onChange(of: self.showNotifications) {
            withAnimation {
                self.showNotificationOptions = self.showNotifications
            }
        }
    }
}

#Preview {
    ManageNotificationScreen()
}
