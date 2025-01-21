//
//  ChallengeCard.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 20/01/25.
//

import SwiftUI

struct ChallengeCard: View {
    
    var colorFrom: Color
    var colorTo: Color
    var title: String
    var helperTitle: String
    var dificulty: String
    var image: String
    var timing: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.custom("RobotCondensed-Medium", size: 18))
                    .foregroundStyle(.white.opacity(1))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(helperTitle)
                    .font(.custom("RobotCondensed-Medium", size: 15))
                    .foregroundStyle(.white.opacity(0.51))
                
                Spacer()
                
                Text(self.timing)
                    .font(.custom("RobotoCondensed-Regular", size: 17))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 17)
                    .padding(.vertical, 6)
                    .background(.black.opacity(0.2))
                    .cornerRadius(100)
                

                Text(self.dificulty)
                    .font(.custom("RobotoCondensed-Regular", size: 17))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 17)
                    .padding(.vertical, 6)
                    .background(.black.opacity(0.2))
                    .cornerRadius(100)

                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(24)

            HStack {
                Image(image)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)

            
        }
        .frame(width: UIScreen.main.bounds.width * 0.9, height: 256)
        .background(
            LinearGradient(gradient: Gradient(colors: [colorFrom, colorTo]), startPoint: .top, endPoint: .bottom)
        )
        .cornerRadius(17)
        
    }
}
