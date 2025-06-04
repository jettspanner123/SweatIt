//
//  FoodRecommendationViewCarc.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 04/06/25.
//

import SwiftUI
struct FoodRecommendationViewCard: View {
    var food: FoodItem
    var deleteRecommendationView: Bool = false
    @Binding var actualArray: Array<FoodItem>
    
    @State var isDeleated: Bool = false
    @State var isShowing: Bool = false
    
    @StateObject var postMethodStore = PostMethodStore.current
    
    func getIcon() -> String {
        switch self.food.foodType {
        case "Junk 💩":
            return ["🍔","🍖", "🍕","🌭", "🌮", "🍟"].shuffled().first!
        case "Clean 🥦":
            return ["🥦", "🌽", "🥑", "🥕", "🍄"].shuffled().first!
        default:
            return ["🥤", "🥛", "🧋", "☕️", "🍷"].shuffled().first!
        }
    }
    
    func removeFromArray() -> Void {
        self.isDeleated = true
        withAnimation {
            self.isShowing = true
            withAnimation(.easeInOut(duration: 0.75).delay(1)) {
                self.actualArray = self.actualArray.filter {$0.id != self.food.id}
            }
        }
    }
    
    func handleRecommendation() -> Void {
        self.isDeleated = false
        let food_t: Food_t = .init(foodName: self.food.foodName, foodDescription: self.food.foodDescription, foodQuantity: self.food.foodQuantity, calories: self.food.caloriesPerGram, foodImage: "", foodType: Extras.FoodType(rawValue: self.food.foodType)!, protein: self.food.protienPerGram, carbs: self.food.carbsPerGram, fats: self.food.fatsPerGram)
        
        
        
        
        Task {
            try await ApplicationEndpoints.post.addFoodRecommendation(forUserId: User.current.currentUser.id, withFood: food_t)
            
            withAnimation {
                self.isShowing = true
                withAnimation(.easeInOut(duration: 0.75).delay(1)) {
                    self.actualArray = self.actualArray.filter {$0.id != self.food.id}
                }
            }
        }
    }
    
    
    var body: some View {
        HStack(spacing: 15) {
            
            // MARK: ICON
            HStack {
                Text(self.getIcon())
                    .font(.system(size: 30))
            }
            .frame(maxHeight: .infinity)
            .frame(width: 70)
            .background(.white.opacity(0.08), in: RoundedRectangle(cornerRadius: 8))
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.white.opacity(0.1), lineWidth: 1)
            }
            
            VStack {
                
                // MARK: FOod name
                Text(self.food.foodName)
                    .font(.system(size: 15))
                    .takeMaxWidthLeading()
                    .overlay(alignment: .trailing) {
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.white.opacity(0.5))
                            .scaleEffect(0.75)
                    }
                
                
                // MARK: Fod calories
                HStack {
                    
                    Text(String(format: "%.f kCal", self.food.caloriesPerGram * 100))
                        .font(.system(size: 13, weight: .regular, design: .rounded))
                        .foregroundStyle(.white)
                    
                    Text("🥬")
                        .font(.system(size: 10))
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 5)
                
                
                // MARK: Food macros
                HStack {
                    HStack(spacing: 5) {
                        Text(String(format: "%.fg", self.food.protienPerGram * 100))
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
                        Text(String(format: "%.fg", self.food.carbsPerGram * 100))
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
                
                
                
                
                // MARK: Twin accept/decline button
                HStack {
                    if !self.deleteRecommendationView {
                        HStack {
                            if self.postMethodStore.isDatabaseLoading {
                                ProgressView()
                                    .tint(.white)
                                    .scaleEffect(0.5)
                            } else {
                                Text("Recommend")
                                    .font(.system(size: 12, weight: .medium, design: .rounded))
                                    .foregroundStyle(.white)
                            }
                            
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 35)
                        .background(ApplicationLinearGradient.greenGradient, in: RoundedRectangle(cornerRadius: 8))
                        .onTapWithScaleVibrate {
                            self.handleRecommendation()
                        }
                        
                        HStack {
                            Text("Discourage")
                                .font(.system(size: 12, weight: .medium, design: .rounded))
                                .foregroundStyle(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 35)
                        .background(ApplicationLinearGradient.redGradient, in: RoundedRectangle(cornerRadius: 8))
                        .onTapWithScaleVibrate {
                            self.removeFromArray()
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 5)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.vertical, 5)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(.darkBG.opacity(0.54), in: defaultShape)
        .overlay {
            defaultShape
                .stroke(.white.opacity(0.08), lineWidth: 1)
        }
        .overlay {
            if self.isShowing {
                HStack {
                    
                    if self.isDeleated {
                        Image(systemName: "trash.fill")
                            .resizable()
                            .frame(width: 50, height: 60)
                            .foregroundStyle(.white)
                    } else {
                        Image(systemName: "checkmark.seal.fill")
                            .resizable()
                            .frame(width: 55, height: 55)
                            .foregroundStyle(.white)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(self.isDeleated ? ApplicationLinearGradient.redGradient : ApplicationLinearGradient.greenGradient, in: defaultShape)
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            }
        }
    }
}

