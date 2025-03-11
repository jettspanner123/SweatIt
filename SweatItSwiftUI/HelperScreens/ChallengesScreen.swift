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
    
    @State var filteredChallengesList: Array<Challenge_t> = []
    @State var showChallengeDetailsView: Bool = false
    @State var selectedChallenge: Challenge_t? = nil
    
    
    func searchBoxOnChangeEvent() -> Void {
        self.filteredChallengesList = self.challengesList.filter {
            $0.challengeName.lowercased().starts(with: self.searchText.lowercased())
        }
    }
    
    
    var body: some View {
        ScreenBuilder {
            AccentPageHeader(pageHeaderTitle: "Challenges")
            
            if self.showChallengeDetailsView {
                ChallengeDetailsScreen(challenge: self.selectedChallenge!, showChallengeDetailView: self.$showChallengeDetailsView)
                    .transition(.offset(y: UIScreen.main.bounds.height))
            }
            
            
            ScrollContentView {
                
                // MARK: Search box and filter
                CustomTextField(searchText: self.$searchText, placeholder: "Search")
                    .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                
                if self.searchText.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(Extras.Difficulty.allCases, id: \.self) { difficutly in
                                
                                // MARK: Conditional rendering tab buttons
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
                }
                
                
                // MARK: Rendering all the challenges cards
                
                SectionHeader(text: "Challenges 🔥")
                    .padding(.top, 20)
                    .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                
                
                // MARK: If challenges card not found
                if self.challengesList.filter ({ $0.challengeDifficulty == self.selectedDifficulty }).isEmpty && self.selectedDifficulty != .all {
                    NotFound(text: "No Challenges Found")
                }
                
                
                
                
                // MARK: This is only running if the search box is empty
                if self.searchText.isEmpty {
                    ForEach(self.challengesList, id: \.id) { challenge in
                        if self.selectedDifficulty == challenge.challengeDifficulty || self.selectedDifficulty == .all {
                            ChallengeViewCard(challenge: challenge)
                                .onTapGesture {
                                    self.selectedChallenge = challenge
                                    withAnimation(.smooth) {
                                        self.showChallengeDetailsView = true
                                    }
                                }
                                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                                .transition(.offset(y: UIScreen.main.bounds.height))
                        }
                        
                    }
                    
                    // MARK: This is running when the search box has a result
                } else {
                    
                    // MARK: Handle if the list is empty
                    if self.filteredChallengesList.isEmpty {
                        NotFound(text: "No Challenges Found!")
                    }
                    ForEach(self.filteredChallengesList, id: \.id) { challenge in
                        ChallengeViewCard(challenge: challenge)
                            .onTapGesture {
                                self.selectedChallenge = challenge
                                withAnimation(.smooth) {
                                    self.showChallengeDetailsView = true
                                }
                            }
                            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                            .transition(.offset(y: UIScreen.main.bounds.height))
                        
                    }
                }
            }
        }
    }
}


struct NotFound: View {
    var text: String
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundStyle(.white.opacity(0.15))
                .padding(.top, 100)
            
            Text(self.text)
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundStyle(.white.opacity(0.25))
        }
    }
}



#Preview {
    ChallengesScreen()
}
