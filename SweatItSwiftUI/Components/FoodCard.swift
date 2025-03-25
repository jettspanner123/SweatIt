//
//  FoodCard.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 25/03/25.
//

import SwiftUI

struct FoodCard: View {
    var food: Food_t
    var isViewCard: Bool = false
    
    var body: some View {
        HStack {
            
            // MARK: Image VIew
            HStack {
                Image("rice")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .opacity(0.5)
            }
            .frame(maxHeight: .infinity)
            .frame(width: 120)
            
            // MARK: Content view
            VStack(spacing: 5) {
                
                // MARK: Food name
                Text(self.food.foodName)
                    .font(.custom(ApplicationFonts.oswaldRegular, size: 15))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 10)
                
                
                
                // MARK: Calories of food
                HStack {
                    
                    Text(String(format: "%.f kCal", self.food.calories))
                        .font(.system(size: 13, weight: .regular, design: .rounded))
                        .foregroundStyle(.white)
                    
                    Text("🥬")
                        .font(.system(size: 10))
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
                .padding(.bottom, 5)
                
                
                HStack {
                    HStack(spacing: 5) {
                        Text(String(format: "%.fg", self.food.protein))
                            .font(.custom(ApplicationFonts.oswaldRegular, size: 13))
                            .foregroundStyle(.white)
                        
                        Text("🍖")
                            .font(.system(size: 20))
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 3)
                    .background(.darkBG.opacity(0.54))
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.white.opacity(0.18))
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    HStack(spacing: 5) {
                        Text(String(format: "%.fg", self.food.carbs))
                            .font(.custom(ApplicationFonts.oswaldRegular, size: 13))
                            .foregroundStyle(.white)
                        
                        Text("🍞")
                            .font(.system(size: 20))
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 3)
                    .background(.darkBG.opacity(0.54))
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.white.opacity(0.18))
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.vertical, 15)
        }
        .frame(maxWidth: .infinity)
        .frame(height: self.isViewCard ? 90 : 110)
        .background(self.isViewCard ? .darkBG.opacity(0.54) : .clear)
        .overlay {
            self.isViewCard ? defaultShape.stroke(.white.opacity(0.18)) : RoundedRectangle(cornerRadius: 0).stroke(.clear)
        }
        .clipShape(self.isViewCard ? defaultShape : RoundedRectangle(cornerRadius: 0))
        .overlay {
            HStack {
                Image(systemName: "chevron.right")
                    .scaleEffect(0.75)
                    .foregroundStyle(.white.opacity(0.75))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(25)
        }
    }
}
