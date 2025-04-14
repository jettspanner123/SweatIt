//
//  ExerciseDetailsScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 11/03/25.
//

import SwiftUI

struct ExerciseDetailsScreen: View {
    
    var exercise: Exercise_t
    var body: some View {
        ScreenBuilder {
            
            AccentPageHeader(pageHeaderTitle: self.exercise.exerciseName)
           
            ScrollContentView {
                
                
                // MARK: List of exericse details
                CustomList {
                    SpaceSeparatedKeyValue(key: "Name", value: self.exercise.exerciseName)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    
                    CustomDivider()
                    
                    SpaceSeparatedKeyValue(key: "Per Rep Calorie Burned", value: String(self.exercise.perRepCaloriesBurned) + " 🔥")
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    
                }
                
                // MARK: Exercise description
                SectionHeader(text: "Description")
                    .padding(.top, 20)
                
                CustomList {
                    Text(self.exercise.exerciseDescription)
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundStyle(.white.opacity(0.75))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                }
                
                
                // MARK: List of muscles
                SectionHeader(text: "Muscles Worked")
                    .padding(.top, 20)
                
                CustomList {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(self.exercise.targettedMuscles, id: \.self) { muscle in
                                Text(muscle.rawValue)
                                    .font(.system(size: 12, weight: .regular, design: .rounded))
                                    .foregroundStyle(.white)
                                    .padding(8)
                                    .padding(.horizontal, 4)
                                    .background(ApplicationLinearGradient.redGradient)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(.white.opacity(0.18))
                                    }
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                        }
                        .padding(.vertical, 5)
                        .padding(.horizontal)
                    }
                }
                
                SectionHeader(text: "Exercise Preview")
                    .padding(.top, 20)
                
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
                        case .failure:
                            Text("Image Not Found!")
                                .font(.system(size: 15, weight: .semibold, design: .rounded))
                                .foregroundStyle(.darkBG)
                        @unknown default:
                            Text("Some Error Occured!")
                                .font(.system(size: 15, weight: .semibold, design: .rounded))
                                .foregroundStyle(.darkBG)
                        }
                    }
                }
                .padding(25)
                .frame(width: UIScreen.main.bounds.width - (ApplicationPadding.mainScreenHorizontalPadding * 2), height: 400)
                .background(.white)
                .clipShape(defaultShape)
            }
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        }
    }
}

#Preview {
    ExerciseDetailsScreen(exercise: Exercise.current.pushUp)
}
