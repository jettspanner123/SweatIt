//
//  RatingsScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 14/04/25.
//

import SwiftUI

struct RatingsScreen: View {
    @EnvironmentObject var appStates: ApplicationStates
    
    enum RatingScreenType: String {
        case bad, average, good
    }
    
    @State var sliderValue: Double = 0.5
    
    func calculateRatingBackground(withOpacity opacity: Double = 1) -> Color {
        if self.sliderValue == 0 {
            return .ratingRed.opacity(opacity)
        } else if self.sliderValue == 0.5 {
            return .ratingBrown.opacity(opacity)
        } else {
            return .ratingGreen.opacity(opacity)
        }
    }
    
    func calculateRatingForeground(withOpacity opacity: Double = 1) -> Color {
        if self.sliderValue == 0 {
            return .ratingDarkRed.opacity(opacity)
        } else if self.sliderValue == 0.5 {
            return .ratingDarkBrown.opacity(opacity)
        } else {
            return .ratingDarkGreen.opacity(opacity)
        }
    }
    
    var currentSelectedPage: RatingScreenType {
        if self.sliderValue == 0 {
            return .bad
        } else if self.sliderValue == 0.5 {
            return .average
        } else {
            return .good
        }
    }
    
    func nextButtonFunction() -> Void {
        if self.sliderValue == 0 {
            withAnimation {
                self.sliderValue = 0.5
            }
        } else if self.sliderValue == 0.5 {
            withAnimation {
                self.sliderValue = 1
            }
        } else {
            return
        }
    }
    
    func previousButtonFunction() -> Void {
        if self.sliderValue == 1 {
            withAnimation {
                self.sliderValue = 0.5
            }
        } else if self.sliderValue == 0.5 {
            withAnimation {
                self.sliderValue = 0
            }
        } else {
            return
        }
    }
    
    
    
    
    var body: some View {
        VStack {
            
            
            
            // MARK: Heading text
           Text("How was your workout experience?")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundStyle(self.calculateRatingForeground())
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding * 3)
                .multilineTextAlignment(.center)
            
            
            
            
            
            
            // MARK: Actual shit here!
            switch self.currentSelectedPage {
            case .bad:
                self.badScreenSmile
                    .transition(.blurReplace)
            case .average:
                self.averageScreenSmile
                    .transition(.blurReplace)
            case .good:
                self.goodScreenSmile
                    .transition(.blurReplace)
            }
            
            
            
            
            
            // MARK: Page description
            Text(self.currentSelectedPage.rawValue.uppercased())
                .font(.custom(ApplicationFonts.oswaldMedium, size: 50))
                .foregroundStyle(self.calculateRatingForeground(withOpacity: 0.75))
                .transition(.blurReplace)
            
            
            
            
            // MARK: Navigation buttons
            HStack {
                
                
                
                // MARK: PRevious button
                HStack {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(self.calculateRatingForeground())
                }
                .frame(width: 60, height: 60)
                .overlay {
                    Circle()
                        .stroke(.white.opacity(0.18))
                }
                .background(self.calculateRatingBackground(), in: Circle())
                .brightness(0.25)
                .opacity(self.sliderValue == 1 ? 0 : 1)
                .onTapWithScale {
                    self.nextButtonFunction()
                }
                
                Spacer()
                
                Text("Choose Option")
                    .font(.system(size: 13, weight: .medium, design: .rounded))
                    .foregroundStyle(self.calculateRatingForeground())
                
                
                Spacer()
                
                
                
                
                // MARK: Next button
                HStack {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(self.calculateRatingForeground())
                }
                .frame(width: 60, height: 60)
                .background(self.calculateRatingBackground(), in: Circle())
                .brightness(0.25)
                .opacity(self.sliderValue == 0 ? 0 : 1)
                .onTapWithScale {
                    self.previousButtonFunction()
                }
                
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding * 2.5)
            
            
            
            
            
            // MARK: Submit button
            HStack {
                
                Text("Submit")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundStyle(self.calculateRatingForeground())
                    
                    
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 15)
            .background(self.calculateRatingBackground(), in: RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding * 2.5)
            .padding(.top, 25)
            .brightness(0.25)
            .onTapWithScaleVibrate {
                
                withAnimation {
                    self.appStates.workoutStatus = .none
                }
                ApplicationSounds.current.completed()
            }
            
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(self.calculateRatingBackground())
        .sensoryFeedback(.impact, trigger: self.currentSelectedPage)
        .onChange(of: self.currentSelectedPage) {
            ApplicationSounds.current.playBubble()
        }
    }
    
    
    var badScreenSmile: some View {
        VStack(spacing: 15) {
            HStack {
                Circle()
                    .fill(.ratingDarkRed)
                    .frame(width: 100, height: 100)
                
                Circle()
                    .fill(.ratingDarkRed)
                    .frame(width: 100, height: 100)
            }
            
            Image(ApplicationImages.reverseSmile)
        }
        .frame(height: 300)
    }
    
    var averageScreenSmile: some View {
        VStack(spacing: 25) {
            HStack {
                RoundedRectangle(cornerRadius: 100)
                    .fill(.ratingDarkBrown)
                    .frame(width: 110, height: 40)
                
                RoundedRectangle(cornerRadius: 100)
                    .fill(.ratingDarkBrown)
                    .frame(width: 110, height: 40)
            }
            
            
            RoundedRectangle(cornerRadius: 100)
                .fill(.ratingDarkBrown)
                .frame(width: 50, height: 10)
        }
        .frame(height: 300)
    }
    
    
    var goodScreenSmile: some View {
        VStack(spacing: 15) {
            HStack {
                Circle()
                    .fill(.ratingDarkGreen)
                    .frame(width: 100, height: 100)
                
                Circle()
                    .fill(.ratingDarkGreen)
                    .frame(width: 100, height: 100)
            }
            
            Image(ApplicationImages.smile)
        }
        .frame(height: 300)
    }
}

