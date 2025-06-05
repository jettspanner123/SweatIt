//
//  ChallengeDetailsScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 11/03/25.
//

import SwiftUI

struct ChallengeDetailsScreen: View {
    
    var challenge: Challenge_t
    @Binding var showChallengeDetailView: Bool
    
    @State var pageTranslation: CGSize = .zero
    
    var body: some View {
        VStack {
            HStack {
                
                // MARK: Content title
                Text(self.challenge.challengeName)
                    .font(.system(size: 25, weight: .light, design: .rounded))
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity)
            // MARK: Close button
            .overlay {
                HStack {
                    Image(systemName: "xmark")
                        .foregroundStyle(.white)
                        .padding()
                        .background(.white.opacity(0.001))
                        .offset(x: -5)
                        .onTapGesture {
                            withAnimation(.smooth) {
                                self.showChallengeDetailView = false
                            }
                        }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            }
            
            SectionHeader(text: "Content Description")
                .padding(.top, 20)
            
            // MARK: Challenge description
            CustomList {
                Text(self.challenge.challengeExtendedDescription)
                    .font(.system(size: 12, weight: .light, design: .rounded))
                    .foregroundStyle(.white.opacity(0.75))
                    .padding(.horizontal, 10)
                    .padding(.bottom, 40)
            }
            
            SectionHeader(text: "Contest Details")
                .padding(.top)
            
            CustomList {
                HStack {
                    
                    Text(self.challenge.challengeDifficulty.rawValue)
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(self.challenge.challengeDifficulty == .hard ? ApplicationLinearGradient.redGradient : self.challenge.challengeDifficulty == .medium ? ApplicationLinearGradient.goldenGradient : ApplicationLinearGradient.greenGradient)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                    
                    
                    Text(ApplicationHelper.getTimeFromDate(self.challenge.duration))
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(ApplicationLinearGradient.thanosGradient)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
                
            }
            
            Spacer()
            
            BottomBluredButton(disabledText: "Comming Soon")
                .offset(y: 30)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.vertical, ApplicationPadding.mainScreenVerticalPadding-20)
        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        .background(AppBackgroundBlur(radius: 100, opaque: true))
        .background(.darkBG.opacity(0.18))
        .zIndex(110)
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
                    if value.translation.height < 150 {
                        withAnimation(.bouncy) {
                            self.pageTranslation = .zero
                        }
                    } else {
                        withAnimation(.smooth) {
                            self.showChallengeDetailView = false
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            self.pageTranslation = .zero
                        }
                    }
                }
        )
        .ignoresSafeArea()
    }
}


struct BottomBluredButton: View {
    var text: String = ""
    var background: LinearGradient = ApplicationLinearGradient.redGradient
    var disabledText: String = ""
    
    
    var action: () -> Void = {}
    
    var body: some View {
        HStack {
            if self.disabledText.isEmpty {
                Text(self.text)
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundStyle(.white)
            } else {
                
                Image(systemName: "lock.fill")
                    .foregroundStyle(.white)
                
                Text(self.disabledText)
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundStyle(.white)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 40)
        .background(self.background)
        .clipShape(defaultShape)
        .onTapWithScaleVibrate {
            self.action()
        }
    }
}

#Preview {
    VStack {
        BottomBluredButton(background: ApplicationLinearGradient.redGradient, disabledText: "Comming Soon")
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.blue)
}
