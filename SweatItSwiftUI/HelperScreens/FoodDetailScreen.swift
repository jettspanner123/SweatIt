//
//  FoodDetailScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 14/03/25.
//

import SwiftUI

struct FoodDetailScreen: View {
    var food: Food_t = Food.current.sandwich
    
    @Environment(\.dismiss) var dismiss
    
    var image: UIImage {
        let image = UIImage(named: self.food.foodImage)!
        return image
    }
    
    @State var colors: Array<Color> = []
    
    
    var body: some View {
        ZStack(alignment: .top) {
            
            
            HStack(spacing: 15) {
                
                // MARK: Back button
                HStack {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black)
                    
                }
                .frame(width: 35, height: 35)
                .background(.white.opacity(0.75))
                .clipShape(Circle())
                .onTapGesture {
                    self.dismiss()
                }
                
                // MARK: Food name
                Text(self.food.foodName)
                    .font(.custom(ApplicationFonts.oswaldRegular, size: 30))
                    .foregroundStyle(.white)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding * 2)
            .offset(y: 10)
            .zIndex(100)
            
            
            // MARK: image view
            HStack {
                Image(self.food.foodImage)
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 400)
            
            
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    
                    
                    ForEach(1...3, id: \.self) { _ in
                        HStack {
                            Text("")
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                    }
                }
                .frame(maxWidth: .infinity)
                .background(AppBackgroundBlur(radius: 100, opaque: true))
                .padding(.top, 300)
                .overlay {
                    HStack {
                        RoundedRectangle(cornerRadius: 10)
//                            .fill(AppBackgroundBlur(radius: 100, opaque: true))
                            .fill(.darkBG)
                            .frame(maxWidth: .infinity)
                            .frame(height: 1400)
                            .visualEffect { view, phase in
                                view
                                    .offset(y: phase.bounds(of: .named("CustomScrollView"))!.maxY - 260)
                            }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    .coordinateSpace(name: "CustomScrollView")
                }
                .overlay {
                    VStack {
                        
                        
                        // MARK: Ye jaga chodne ke liye
                        HStack {
                            
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 300)
                       
                        
                        
                        // MARK: YE hai aapna macro stack
                        HStack {
                           
                            
                            
                            // MARK: Proteing bnox
                            HStack {
                                Text(String(format: "%.fg", self.food.protein))
                                    .font(.custom(ApplicationFonts.oswaldRegular, size: 25))
                                    .foregroundStyle(.white)
                                
                                Text("🍖")
                                    .font(.system(size: 25))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(ApplicationLinearGradient.redGradient)
                            .overlay {
                                defaultShape
                                    .stroke(.white.opacity(0.18))
                            }
                            .clipShape(defaultShape)
                            
                            
                            
                            // MARK: Carbs box
                            HStack {
                                Text(String(format: "%.fg", self.food.carbs))
                                    .font(.custom(ApplicationFonts.oswaldRegular, size: 25))
                                    .foregroundStyle(.white)
                                
                                Text("🍞")
                                    .font(.system(size: 25))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(ApplicationLinearGradient.brownGradient)
                            .overlay {
                                defaultShape
                                    .stroke(.white.opacity(0.18))
                            }
                            .clipShape(defaultShape)
                            
                            
                            
                            // MARK: Fats box
                            HStack {
                                Text(String(format: "%.fg", self.food.protein))
                                    .font(.custom(ApplicationFonts.oswaldRegular, size: 25))
                                    .foregroundStyle(.white)
                                
                                Text("🥐")
                                    .font(.system(size: 25))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(ApplicationLinearGradient.redGradient)
                            .overlay {
                                defaultShape
                                    .stroke(.white.opacity(0.18))
                            }
                            .clipShape(defaultShape)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(.vertical, 30)
                    .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                }
            }
            .scrollBounceBehavior(.basedOnSize)
        }
        .background(
            VStack {
                Image(self.food.foodImage)
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height/2)
                    .blur(radius: 100)
            }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .background(ApplicationLinearGradient.applicationGradient)
            
        )
        .navigationBarBackButtonHidden()
        
    }
}

#Preview {
    FoodDetailScreen()
}
