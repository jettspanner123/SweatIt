//
//  DietPageComponents.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 29/01/25.
//

import SwiftUI

struct MacrosCard: View {
    
    var protein: (Int, Int) = (45, 82)
    var carbs: (Int, Int) = (15, 30)
    var fats: (Int, Int) = (15, 18)

    var body: some View {
        VStack {
            Text("Macros")
                .font(.system(size: 25, weight: .light, design: .rounded))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Protein")
                .font(.system(size: 17, weight: .light, design: .rounded))
                .foregroundStyle(.white.opacity(0.5))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 15)
            
            
            HStack {
                HStack {
                    Text("\(self.protein.0)")
                        .font(.custom("Oswald-Regular", size: 20))
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 15)
                .frame(maxWidth: 200, maxHeight: .infinity, alignment: .trailing)
                .background(
                    LinearGradient(gradient: Gradient(colors: [.appGreenDark, .appGreenLight]), startPoint: UnitPoint(x: 0, y: 0.5), endPoint: UnitPoint(x: 1, y: 0.5))
                )
                .cornerRadius(10)
            
                Text("\(self.protein.1)")
                        .font(.custom("Oswald-Regular", size: 20))
                        .foregroundStyle(.white.opacity(0.35))
                        .offset(x: 80)
                
            }
            .frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
            .background(
                .appGreenDark.opacity(0.35)
            )
            .cornerRadius(10)
            
            Text("Carbs")
                .font(.system(size: 17, weight: .light, design: .rounded))
                .foregroundStyle(.white.opacity(0.5))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 15)
            
            HStack {
                HStack {
                    Text("\(self.carbs.0)")
                        .font(.custom("Oswald-Regular", size: 20))
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 15)
                .frame(maxWidth: 150, maxHeight: .infinity, alignment: .trailing)
                .background(
                    LinearGradient(gradient: Gradient(colors: [.appBrownDark, .appBrownLight]), startPoint: UnitPoint(x: 0, y: 0.5), endPoint: UnitPoint(x: 1, y: 0.5))
                )
                .cornerRadius(10)
            
                Text("\(self.carbs.1)")
                        .font(.custom("Oswald-Regular", size: 20))
                        .foregroundStyle(.white.opacity(0.35))
                        .offset(x: 130)
                
            }
            .frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
            .background(
                .appGreenDark.opacity(0.35)
            )
            .cornerRadius(10)
            
            
            Text("Fats")
                .font(.system(size: 17, weight: .light, design: .rounded))
                .foregroundStyle(.white.opacity(0.5))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 15)
            
            HStack {
                HStack {
                    Text("\(self.fats.0)")
                        .font(.custom("Oswald-Regular", size: 20))
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 15)
                .frame(maxWidth: 290, maxHeight: .infinity, alignment: .trailing)
                .background(
                    LinearGradient(gradient: Gradient(colors: [.appGoldDark, .appGoldLight]), startPoint: UnitPoint(x: 0, y: 0.5), endPoint: UnitPoint(x: 1, y: 0.5))
                )
                .cornerRadius(10)
            
                Text("\(self.fats.1)")
                        .font(.custom("Oswald-Regular", size: 20))
                        .foregroundStyle(.white.opacity(0.35))
                        .offset(x: -10)
                
            }
            .frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
            .background(
                .appGreenDark.opacity(0.35)
            )
            .cornerRadius(10)
            .padding(.bottom, 10)
        }
        .padding(20)
        .frame(maxWidth: UIScreen.main.bounds.width * 0.9)
        .background(.darkBG.opacity(0.54))
        .cornerRadius(17)
        .overlay(
            RoundedRectangle(cornerRadius: 17)
                .stroke(.white.opacity(0.08))
        )
    }
}

struct RatingFoodCard: View {
    var isTop: Bool = false
    var isBottom: Bool = false
    var name: String = "Basmati Rice"
    var title: String = "Carbs: 28g, Protein: 0, Fats: 5g"
    var cal: Int = 130
    var image: String = "rice"
    
    var body: some View {
        ZStack {
            
            
            Image("BackPage")
                .resizable()
                .frame(width: 20, height: 20)
                .rotationEffect(.degrees(180))
                .offset(x: UIScreen.main.bounds.width / 2 - 40)
            HStack {
            HStack {
                Image(self.image)
                    .resizable()
            }
            .frame(width: 150, height: 150)
            .background(.white)
            
            VStack {
                Text(self.name)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(self.title)
                    .font(.system(size: 15, weight: .light, design: .rounded))
                    .foregroundStyle(.white.opacity(0.5))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("🥦 \(self.cal) kCal")
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 5)

            }
            .padding()
        }
        .frame(maxWidth: UIScreen.main.bounds.width * 0.9, maxHeight: 140, alignment: .leading)
        .background(.darkBG.opacity(0.54))
        .clipShape(
            UnevenRoundedRectangle(cornerRadii: .init(topLeading: isTop ? 17: 0, bottomLeading: isBottom ? 17 : 0, bottomTrailing: isBottom ? 17 : 0, topTrailing: isTop ? 17 : 0))
        )
        .overlay(
            UnevenRoundedRectangle(cornerRadii: .init(topLeading: isTop ? 17: 0, bottomLeading: isBottom ? 17 : 0, bottomTrailing: isBottom ? 17 : 0, topTrailing: isTop ? 17 : 0))
                .stroke(.white.opacity(0.08))
        )
        }
    }
}


struct FoodRecommendationCard: View {
    var body: some View {
        VStack {
            ZStack {
                Image("rice")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                HStack {
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(AppBackgroundBlur())
                .background(
                    LinearGradient(gradient: Gradient(colors: [.black.opacity(0.5), .black.opacity(0)]), startPoint: .top, endPoint: .bottom)
                )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            
            HStack {
                Text("Add")
                    .font(.system(size: 20, weight: .light, design: .rounded))
                    .foregroundStyle(.blue)
                    
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            .overlay(
                Rectangle()
                    .stroke(.white.opacity(0.08))
            )
            
            
            HStack {
                Text("Don't Recommend")
                    .font(.system(size: 20, weight: .light, design: .rounded))
                    .foregroundStyle(.red)
            }
            .frame(maxWidth: .infinity, maxHeight: 56)
            .background(
                LinearGradient(gradient: Gradient(colors: [.appBloodRedDark.opacity(0.22), .appBloodRedLight.opacity(0.22)]), startPoint: .top, endPoint: .bottom)
            )
        }
        .frame(maxWidth: UIScreen.main.bounds.width * 0.85, maxHeight: 350)
        .background(.darkBG.opacity(0.54))
        .cornerRadius(17)
    }
}

#Preview {
    FoodRecommendationCard()
}
