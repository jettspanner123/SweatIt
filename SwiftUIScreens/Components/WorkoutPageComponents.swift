//
//  WorkoutPageComponents.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 21/01/25.
//

import SwiftUI

struct PrimaryButton : View{
    
    var title: String
    var icon: String
    var colors: Array<Color>
    
    var body: some View{
        HStack {
            Image(icon)
                .resizable()
                .frame(width: 30, height: 30)
            
            Text(title)
                .font(.custom("Oswald-Regular", size: 20))
                .foregroundStyle(.white.opacity(0.61))
            
            HStack {
               Image("BackPage")
                    .resizable()
                    .frame(width: 15, height: 15)
            }
            .frame(width: 30, height: 30)
            .background(.black.opacity(0.17))
            .cornerRadius(100)
            .rotationEffect(.degrees(180))
        }
        .frame(width: UIScreen.main.bounds.width / 2 - 30, height: 77)
        .background(
            LinearGradient(gradient: Gradient(colors: [self.colors.first ?? .black, self.colors.last ?? .black]), startPoint: .top, endPoint: .bottom)
        )
        .cornerRadius(17)
    }
}

struct WorkoutPageSearchBar: View {
    var body: some View {
        HStack {
            Text("Search")
                .font(.custom("Poppins-Medium", size: 20))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 24)
        .frame(width: UIScreen.main.bounds.width * 0.9)
        .frame(height: 58)
        .background(Color.darkBG.opacity(0.54))
        .cornerRadius(17)
        .overlay {
            RoundedRectangle(cornerRadius: 17)
                .stroke(.white.opacity(0.18))
        }

        
        
    }
}

struct WorkoutCard: View {
    
    var image: String
    var name: String
    var difficulty: String
    
    var body: some View {
        ZStack {
            
            Image("upperbody")
                .offset(x: 20)
            HStack(alignment: .top) {
                VStack(spacing: 10) {
                   Text("Upper Body")
                        .font(.custom("RobotoCondensed-Regular", size: 30))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    
                    Text("Hard")
                        .padding(.vertical, 6)
                        .padding(.horizontal, 10)
                        .font(.custom("Poppins-Light", size: 15))
                        .foregroundStyle(.white)
                        .background(.white.opacity(0.1))
                        .cornerRadius(100)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                HStack(alignment: .center) {
                    Image("BackPage")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .rotationEffect(.degrees(180))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
        .padding(25)
        .frame(width: UIScreen.main.bounds.width * 0.9, height: 134)
        .background(.darkBG.opacity(0.54))
        .cornerRadius(17)
        .overlay {
            RoundedRectangle(cornerRadius: 17)
                .stroke(.white.opacity(0.16))
        }
        
        
    }
}


#Preview {
}
