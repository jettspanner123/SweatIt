//
//  ExerciseCard.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 20/01/25.
//

import SwiftUI

struct ExerciseExpandableCard: View {
    var exerciseName: String
    var muscleGroups: Array<String>
    var weekdays: Array<(Bool, Int)>
    var colors: Array<Color>
    @State var isExpanded: Bool = true
    @Namespace var namespace
    
    var body: some View {
        ZStack {
            HStack {
                Image("BackPage")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .scaleEffect(x: -1, y: 1, anchor: .center)
                    .rotationEffect(.degrees(self.isExpanded ? 90 : -90))
            }
            .frame(width: 50, height: 50)
            .background(.black.opacity(0.3))
            .cornerRadius(100)
            .onTapGesture {
                withAnimation {
                    self.isExpanded.toggle()
                }
            }
            .offset(x: 150, y: isExpanded ? -110 : 0)
            
            
            
            Text(exerciseName)
                .font(.system(size: 25, weight: .regular))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .offset(y: isExpanded ? -120 : 0)
                .matchedGeometryEffect(id: "Heading", in: namespace)
            
            if isExpanded {
                HStack {
                    ForEach(self.muscleGroups, id: \.self) { item in
                        HStack {
                            Text(item)
                                .font(.system(size: 15, weight: .regular, design: .rounded))
                                .foregroundStyle(.white)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(.white.opacity(0.2))
                        .cornerRadius(100)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .offset(y: -80)
                
                Text("Levels: ")
                    .font(.system(size: 15, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 20)
                    .padding(.horizontal, 10)
                    .offset(y: -40)
                
                HStack {
                    ForEach(self.weekdays, id: \.self.1) { item in
                        VStack {
                            if item.0 {
                                Image("Done")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .offset(y: 20)
                            }
                            
                            Spacer()
                            
                            Text("0\(item.1)")
                                .font(.custom("Oswald-Regular", size: 20))
                                .foregroundStyle(.white)
                                .offset(y: -20)
                        }
                        .frame(width: 50, height: 143)
                        .background(item.0 ? .black.opacity(0.3) : .white.opacity(0.3))
                        .cornerRadius(17)
                        .padding(.vertical, 10)
                    }
                }
                .frame(maxWidth: .infinity)
                .offset(y: 60)
                
            }
            
        }
        .frame(maxWidth: UIScreen.main.bounds.width * 0.8)
        .frame(height: isExpanded ? 270 : 50)
        .padding(25)
        .background(
            LinearGradient(gradient: Gradient(colors: [self.colors[0], self.colors[1]]), startPoint: .top, endPoint: .bottom)
        )
        .cornerRadius(35)
        .matchedGeometryEffect(id: "Frame", in: namespace)
    }
}

