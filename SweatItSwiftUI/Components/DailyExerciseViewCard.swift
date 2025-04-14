//
//  DailyExerciseViewCard.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 12/04/25.
//

import SwiftUI

struct DailyExerciseViewCard: View {
    
    var exercise: Exercise_t
    var body: some View {
        HStack {
            
            // MARK: Image view
            HStack {
                AsyncImage(url: URL(string: ApplicationHelper.getImageFrom(exercise: self.exercise.image, of: 400))) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .tint(.darkBG)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    case .failure(let error):
                        Text("Failed 🥺")
                            .font(.system(size: 12, weight: .semibold, design: .rounded))
                            .foregroundStyle(.white)
                    @unknown default:
                        Text("Error!")
                            .font(.system(size: 12, weight: .semibold, design: .rounded))
                            .foregroundStyle(.white)
                    }
                }
                
            }
            .padding()
            .frame(maxHeight: .infinity)
            .frame(width: 100)
            .background(.white)
            
            // MARK: Content view
            VStack(spacing: 15) {
                Text(self.exercise.exerciseName + " 🔥")
                    .font(.custom(ApplicationFonts.oswaldRegular, size: 15))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                HStack {
                    
                    // MARK: Difficulty
                    HStack(spacing: 5) {
                        Text(self.exercise.difficulty.rawValue)
                            .font(.custom(ApplicationFonts.oswaldRegular, size: 13))
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 3)
                    .background(self.exercise.difficulty == .easy ? ApplicationLinearGradient.greenGradient : self.exercise.difficulty == .medium ? ApplicationLinearGradient.goldenGradient : ApplicationLinearGradient.redGradient)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.white.opacity(0.18))
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    
                    
                    // MARK: Rendering muscles
                    ForEach(self.exercise.targettedMuscles.prefix(1), id: \.self) { muscle in
                        HStack(spacing: 5) {
                            Text(muscle.rawValue)
                                .font(.custom(ApplicationFonts.oswaldRegular, size: 13))
                                .foregroundStyle(.white)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 3)
                        //                        .background(.darkBG.opacity(0.54))
                        .background(ApplicationLinearGradient.redGradient)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.white.opacity(0.18))
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                    }
                    
                    if self.exercise.targettedMuscles.count > 2 {
                        
                        Image(systemName: "ellipsis")
                            .resizable()
                            .frame(width: 10, height: 3)
                            .foregroundStyle(.white.opacity(0.5))
                            .offset(y: 5)
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.vertical)
            .overlay {
                
                // MARK: Navigation icon
                HStack {
                    Image(systemName: "chevron.right")
                        .scaleEffect(0.75)
                        .foregroundStyle(.white.opacity(0.5))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                .padding(25)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 90,  alignment: .leading)
        .background(.darkBG.opacity(0.54))
    }
}

