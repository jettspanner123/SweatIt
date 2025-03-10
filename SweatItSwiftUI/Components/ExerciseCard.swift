//
//  ExerciseCard.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 20/01/25.
//

import SwiftUI

struct ExerciseExpandableCard: View {
    
    var exerciseText: String = ""
    var exerciseMuscles: Array<Extras.Muscle> = [.chest, .triceps, .shoulders]
    
    @State var showExpandedView: Bool = true
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: Non expanded view
            HStack {
                Text(self.exerciseText)
                    .font(.custom(ApplicationFonts.oswaldRegular, size: 22))
                    .foregroundStyle(.white)
                
                Spacer()
                
                HStack {
                    Image(systemName: "chevron.down")
                        .foregroundStyle(.white)
                        .scaleEffect(0.75)
                        .rotationEffect(.degrees(self.showExpandedView ? 180 : 0))
                }
                .frame(width: 30, height: 30)
                .background(.darkBG.opacity(0.25))
                .clipShape(Circle())
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            // MARK: Expanded content
            if self.showExpandedView {
                HStack {
                    
                    // MARK: Exercise targetted muscles
                    ForEach(self.exerciseMuscles, id: \.self) { muscle_t in
                        Text(muscle_t.rawValue)
                            .font(.system(size: 12, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                            .padding(10)
                            .background(.white.opacity(0.1))
                            .overlay {
                                Capsule()
                                    .stroke(.white.opacity(0.18))
                            }
                            .clipShape(Capsule())
                        
                        
                    }

                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 10)
                .transition(.offset(y: 100))
                
                Text("Frequency: ")
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 5)
                    .padding(.bottom, 10)
                    .transition(.offset(y: 100))

                HStack {
                    ForEach(1...7, id: \.self) { day in
                        VStack {
                            
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.white.opacity(0.5))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .transition(.offset(y: 100))
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.vertical)
        .background(.white.opacity(0.001))
        .onTapGesture {
            withAnimation(.smooth(duration: 0.4)) {
                self.showExpandedView.toggle()
            }
        }
        .clipped()
    }
}

