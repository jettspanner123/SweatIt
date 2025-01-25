//
//  ProfilePageComponents.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 24/01/25.
//

import SwiftUI

struct ProfilePageImageHeader: View {
    
    var image: Image = Image("bjuice")
    var lastName: String = "Singh"
    var firstName: String = "Uddeshya"
    var streak: Int = 382
    
    var body: some View {
        HStack {
            HStack {
                self.image
                    .offset(y: 10)
            }
            .frame(width: 131, height: 131)
            .background(
                LinearGradient(gradient: Gradient(colors: [.appBlueLight, .appBlueDark]), startPoint: .top, endPoint: .bottom)
            )
            .cornerRadius(100)
            
            HStack {
                VStack {
                    Text(self.lastName)
                        .font(.system(size: 25, weight: .heavy, design: .rounded))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                
                    Text(self.firstName)
                        .font(.system(size: 25, weight: .thin, design: .rounded))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()

                    HStack {
                        Text("\(self.streak)🔥")
                            .font(.system(size: 25, weight: .regular, design: .rounded))
                            .foregroundStyle(.white)

                        
                        Spacer()
                        
                        HStack {
                           Image("addUser")
                        }
                        .frame(maxWidth: 45, maxHeight: 45)
                        .background(.white.opacity(0.07))
                        .cornerRadius(6)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
                
            }
        }
        .frame(maxWidth: UIScreen.main.bounds.width * 0.9)
        .frame(height: 125)
    }
}

struct ProfilePageLevelsCard: View {
    var body: some View {
        HStack {
            HStack {
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            HStack {
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(
//                LinearGradient
//            )
        }
        .frame(maxWidth: UIScreen.main.bounds.width * 0.9)
        .frame(height: 119)
        .background(
            LinearGradient(gradient: Gradient(colors: [.white, Color.appGreyLight]), startPoint: .top, endPoint: .bottom)
        )
        .cornerRadius(16)
    }
}

#Preview {
    ProfilePageLevelsCard()
}
