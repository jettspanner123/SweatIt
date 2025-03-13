//
//  DietScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 11/03/25.
//

import SwiftUI

struct DietScreen: View {
    
    @State var foodItemList: Array<Food_t> = [Food.current.apple, Food.current.friedChicken, Food.current.sandwich, Food.current.smoothie]
    
    @State var dietCompletedPrecentage: CGFloat = 20.0
    
    @Binding var showCameraScreen: Bool 
    var body: some View {
        ScrollContentView {
            
            
            HStack {
                
                
                // MARK: Diet completed today
                GeometryReader { proxy in
                    HStack{
                        
                        
                        // MARK: Actual loader
                        HStack {
                            
                        }
                        .frame(maxHeight: .infinity)
                        .frame(width: (self.dietCompletedPrecentage/100) * proxy.size.width)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [.appGreenDark, .appGreenLight]), startPoint: .leading, endPoint: .trailing)
                        )
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .background(.darkBG.opacity(0.54))
                    .overlay {
                        defaultShape
                            .stroke(.white.opacity(0.18))
                    }
                    .overlay {
                        HStack {
                            
                            
                            Text("Diet")
                                .font(.custom(ApplicationFonts.oswaldRegular, size: 20))
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            Text(String(format: "%.f%%", self.dietCompletedPrecentage))
                                .font(.custom(ApplicationFonts.oswaldRegular, size: 20))
                                .foregroundStyle(.white)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.horizontal, 20)
                        .clipped()
                    }
                    .clipShape(defaultShape)
                }

                
                // MARK: Add meal button
                PrimaryNavigationButton(text: "Add Meal", leadingPadding: 15)
                    .background(defaultShape.fill(ApplicationLinearGradient.orangeGradient))
                    .overlay {
                        HStack {
                            Image("Food")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                    }
                
                
            }
            .frame(maxWidth: .infinity)
            
               
            
            // MARK: Twin buttons
            HStack {
                PrimaryNavigationButton(text: "Scan Food", leadingPadding: 35)
                    .background(defaultShape.fill(ApplicationLinearGradient.redGradient))
                    .overlay {
                        HStack {
                            Image("Barcode")
                                .scaleEffect(0.75)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 15)
                    }
                    .onTapGesture {
                        withAnimation {
                            self.showCameraScreen = true
                        }
                    }
                
                
                PrimaryNavigationButton(text: "Add Food    ")
                    .background(defaultShape.fill(ApplicationLinearGradient.thanosGradient))
                    .overlay {
                        HStack {
                            Image(systemName: "plus")
                                .scaleEffect(1.25)
                                .foregroundStyle(.white.opacity(0.5))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 15)
                    }
            }
            .frame(maxWidth: .infinity)
            
            
            SecondaryHeading(title: "Nutrition", secondaryText: "( per gram of body weight )")
                .padding(.top, 20)
            
            HStack {
                InformationCard(image: "FireLogo", title: "Burned", text: "195 kCal")
                    .background(defaultShape.fill(ApplicationLinearGradient.orangeGradient).opacity(0.85))
                
                InformationCard(image: "Food", title: "Consumed", text: "1900 kCal")
                    .background(defaultShape.fill(ApplicationLinearGradient.greenGradient).opacity(0.85))
                
            }
            .frame(maxWidth: .infinity)
            
            
            // MARK: Protein, Carbs and Fats here.
            MacrosViewCard()
            
            
            
            SecondaryHeading(title: "Calories Intake", secondaryText: "( As per \(ApplicationHelper.formatDateToHumanReadable(date: .now)) )")
                .padding(.top, 20)
            
            
            VStack(spacing: 0) {
                
                ForEach(self.foodItemList.indices, id: \.self) { index in
                    NavigationLink(destination: FoodDetailScreen(food: self.foodItemList[index])) {
                        FoodCard(food: self.foodItemList[index])
                    }
                    
                    if index != self.foodItemList.count - 1 {
                        CustomDivider()
                    }
                }
                
            }
            .frame(maxWidth: .infinity)
            .background(.darkBG.opacity(0.54))
            .overlay {
                defaultShape
                    .stroke(.white.opacity(0.18))
            }
            .clipShape(defaultShape)
            
            
            
        }
        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
    }
}

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
                
                
                // MARK: Food macros
//                
//                if !self.isViewCard {
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        
//                        HStack {
//                            
//                            // MARK: Protien card
//                            Text(String(format: "Protein: %.f g", self.food.protein))
//                                .font(.system(size: 10, weight: .medium, design: .rounded))
//                                .foregroundStyle(.white)
//                                .padding(.horizontal, 8)
//                                .padding(.vertical, 3)
//                                .background(ApplicationLinearGradient.redGradient)
//                                .clipShape(Capsule())
//                            
//                            
//                            // MARK: Carbs card
//                            Text(String(format: "Carbs: %.f g", self.food.carbs))
//                                .font(.system(size: 10, weight: .medium, design: .rounded))
//                                .foregroundStyle(.white)
//                                .padding(.horizontal, 8)
//                                .padding(.vertical, 3)
//                                .background(ApplicationLinearGradient.brownGradient)
//                                .clipShape(Capsule())
//                            
//                            
//                            // MARK: Fats card
//                            Text(String(format: "Fats: %.f g", self.food.fats))
//                                .font(.system(size: 10, weight: .medium, design: .rounded))
//                                .foregroundStyle(.white)
//                                .padding(.horizontal, 8)
//                                .padding(.vertical, 3)
//                                .background(ApplicationLinearGradient.goldenGradient)
//                                .clipShape(Capsule())
//                        }
//                        .frame(maxWidth: .infinity)
//                        .padding(.horizontal, 10)
//                    }
//                }
                
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
