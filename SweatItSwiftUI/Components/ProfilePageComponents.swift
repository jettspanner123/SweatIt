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
    
    @State var level: Int = 17
    @State var friendShipScore: Int = 62
    var body: some View {
        HStack {
            HStack {
                Text("\(self.level)")
                    .font(.custom("Oswald-SemiBold", size: 90))
                
                VStack(alignment: .leading, spacing: -10) {
                    Text("Health")
                        .font(.custom("Poppins-Light", size: 20))
                    
                    Text("Level")
                        .font(.custom("Poppins-Bold", size: 30))
                }
                .offset(y: 15)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            HStack(spacing: 0) {
                Text("\(self.friendShipScore)")
                    .font(.custom("Oswald-SemiBold", size: 90))
                    .foregroundStyle(.white)
                
                Image("Friends")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .offset(y: 20)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.appBlueLight, Color.appBlueDark]), startPoint: .top, endPoint: .bottom)
            )
            
            
        }
        .frame(maxWidth: UIScreen.main.bounds.width * 0.9)
        .frame(height: 125)
        .background(
            LinearGradient(gradient: Gradient(colors: [.white, Color.appGreyLight]), startPoint: .top, endPoint: .bottom)
        )
        .cornerRadius(16)
    }
}


struct SettingLable: View {
    
    var text: String = "Privacy & Security"
    var imageName: String = "User"
    var isTop: Bool = false
    var isBottom: Bool = false
    
    var body: some View {
        HStack {
            Image(self.imageName)
                .resizable()
                .frame(width: 35, height: 30)
                .opacity(0.5)
            
            Text(self.text)
                .font(.custom("Poppins-Light", size: 20))
                .foregroundStyle(.white.opacity(0.75))
            
            Spacer()
            
            Image("BackPage")
                .resizable()
                .frame(width: 25, height: 25)
                .rotationEffect(.degrees(180))
                .opacity(0.5)
            
        }
        .padding(17)
        .frame(maxWidth: UIScreen.main.bounds.width * 0.9)
        .frame(height: 70)
        .background(.darkBG.opacity(0.54))
        .overlay(
            UnevenRoundedRectangle(cornerRadii: .init(topLeading: self.isTop ? 17: 0, bottomLeading: self.isBottom ? 17: 0, bottomTrailing: self.isBottom ? 17: 0, topTrailing: self.isTop ? 17: 0), style: .continuous)
                .stroke(.white.opacity(0.18))
        )
    }
}

struct Performer: View {
    
    var name: String = "jettspanner123"
    var points: Int = 1000
    var imageName: String = "jettspanner"
    var isTop: Bool = false
    var isBottom: Bool = false
    var rank: Int = 1
    
    var body: some View {
        VStack(spacing: 10) {
            // idhar first user honeka
            ZStack {
                HStack {
                    HStack {
                        Image(self.imageName)
                            .resizable()
                            .frame(width: .infinity, height: .infinity)
                    }
                    .frame(width: 120, height: 120)
                    .cornerRadius(17)
                    
                    VStack {
                        Text(self.name.capitalized)
                            .font(.custom("Roboto-Regular", size: 22))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("\(self.points)🔥")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.white)
                    }
                    .offset(y: -25)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Image(self.rank == 1 ? "firstMedal" : self.rank == 2 ? "secondMedal" : "thirdMedal")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .offset(x: 145, y: -50)
                
            }
        }
        .padding(15)
        .frame(maxWidth: UIScreen.main.bounds.width * 0.9)
        .background(
            .darkBG.opacity(0.54)
        )
        .overlay(
            UnevenRoundedRectangle(cornerRadii: .init(topLeading: self.isTop ? 17 : 0, bottomLeading: isBottom ? 17 : 0, bottomTrailing: isBottom ? 17 : 0, topTrailing: isTop ? 17 : 0))
                .stroke(.white.opacity(0.18))
        )
    }
}

