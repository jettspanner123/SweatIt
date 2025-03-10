//
//  ChallengesScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 11/03/25.
//

import SwiftUI

struct ChallengesScreen: View {
    
    @State var searchText: String = ""
    
    @State var selectedDifficulty: Extras.Difficulty = .all
    @State var challengesList: Array<Challenge_t> = Challenge.current.exampleChallengesList
    
    var body: some View {
        ScreenBuilder {
            AccentPageHeader(pageHeaderTitle: "Challenges")
            
            
            ScrollContentView {
                
                // MARK: Search box and filter
                CustomTextField(searchText: self.$searchText, placeholder: "Search")
                    .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(Extras.Difficulty.allCases, id: \.self) { difficutly in
                            if self.selectedDifficulty == difficutly {
                                Text(difficutly.rawValue)
                                    .font(.system(size: 15, weight: .regular, design: .rounded))
                                    .foregroundStyle(.white)
                                    .padding(10)
                                    .background(ApplicationLinearGradient.redGradient)
                                    .overlay {
                                        Capsule()
                                            .stroke(.white.opacity(0.18))
                                    }
                                    .clipShape(Capsule())
                                    .onTapGesture {
                                        withAnimation(.smooth) {
                                            self.selectedDifficulty = difficutly
                                        }
                                    }
                            } else {
                                Text(difficutly.rawValue)
                                    .font(.system(size: 15, weight: .regular, design: .rounded))
                                    .foregroundStyle(.white)
                                    .padding(10)
                                    .background(.darkBG.opacity(0.54))
                                    .overlay {
                                        Capsule()
                                            .stroke(.white.opacity(0.18))
                                    }
                                    .clipShape(Capsule())
                                    .onTapGesture {
                                        withAnimation(.smooth) {
                                            self.selectedDifficulty = difficutly
                                        }
                                    }
                            }
                            
                        }
                    }
                    .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                }
                
                
                // MARK: Rendering all the challenges cards
                
                SectionHeader(text: "Challenges 🔥")
                    .padding(.top, 20)
                    .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                
                ForEach(self.challengesList, id: \.id) { challenge in
                    ChallengeViewCard(challenge: challenge)
                        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                }
            }
        }
    }
}

#Preview {
    ChallengesScreen()
}
