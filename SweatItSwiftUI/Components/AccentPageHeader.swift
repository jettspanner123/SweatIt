//
//  AccentPageHeader.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 20/01/25.
//

import SwiftUI

struct AccentPageHeader: View {
    
    var pageHeaderTitle: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack {
            ZStack {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.white)
                    .scaleEffect(0.9)
                    .padding(20)
                    .background(.darkBG.opacity(0.001))
                    .onTapGesture {
                        self.dismiss()
                    }
                    .offset(x: -160, y: 15)

                Text(pageHeaderTitle)
                    .font(.system(size: 23, weight: .light, design: .rounded))
                    .foregroundStyle(.white)
                    .offset(y: 15)

            }
            .offset(y: 25)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 137)
        .background(AppBackgroundBlur(radius: 50, opaque: true))
        .background(Color("DarkBG").opacity(0.55))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white.opacity(0.18))
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .offset(y: -85)
        .zIndex(100)
        
    }
}

struct AccentPageHeader_WithFavButton: View {
    
    var pageHeaderTitle: String
    var workout: Workout_t
    @State var isFavourite: Bool = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack {
            ZStack {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.white)
                    .padding(20)
                    .background(.darkBG.opacity(0.001))
                    .onTapGesture {
                        self.dismiss()
                    }
                    .offset(x: -160, y: 15)

                Text(pageHeaderTitle)
                    .font(.system(size: 23, weight: .light, design: .rounded))
                    .foregroundStyle(.white)
                    .offset(y: 10)
                
                Image(systemName: self.isFavourite ? "heart.fill" : "heart")
                    .contentTransition(.symbolEffect)
                    .foregroundStyle(self.isFavourite ? ApplicationLinearGradient.redPinkGradient : LinearGradient(gradient: Gradient(colors: [.white, .white]), startPoint: .top, endPoint: .bottom))
                    .scaleEffect(1.25)
                    .padding(20)
                    .background(.darkBG.opacity(0.001))
                    .onTapWithScaleVibrate {
                        ApplicationSounds.current.playBubble()
                        withAnimation {
                            self.isFavourite = true
                        }
                        Task {
                            try await ApplicationEndpoints.post.addCustomWorkout(forUserId: User.current.currentUser.id, workout: self.workout)
                        }
                    }
                    .offset(x: 155, y: 15)
                
            }
            .offset(y: 25)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 137)
        .background(AppBackgroundBlur(radius: 50, opaque: true))
        .background(Color("DarkBG").opacity(0.55))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white.opacity(0.18))
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .offset(y: -85)
        .zIndex(100)
        
    }
}

struct AccentPageHeader_NoAction: View {
    
    var pageHeaderTitle: String
    var icon: String = "chevron.left"
    
    var action: () -> Void = {}
    
    var body: some View {
        HStack {
            ZStack {
                Image(systemName: self.icon)
                    .foregroundStyle(.white)
                    .padding(20)
                    .background(.darkBG.opacity(0.001))
                    .onTapGesture {
                        self.action()
                    }
                    .offset(x: -160, y: 15)

                Text(pageHeaderTitle)
                    .font(.system(size: 23, weight: .light, design: .rounded))
                    .foregroundStyle(.white)
                    .offset(y: 15)
                
            }
            .offset(y: 25)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 137)
        .background(AppBackgroundBlur(radius: 50, opaque: true))
        .background(Color("DarkBG").opacity(0.55))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white.opacity(0.18))
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .offset(y: -85)
        .zIndex(100)
        
    }
}

