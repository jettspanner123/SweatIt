import SwiftUI

struct MacrosViewCard: View {
    
    @EnvironmentObject var appStates: ApplicationStates
    
    
    var protienConsumed: Double {
        var totalProtienConsumed: Double = .zero
        for meal in self.appStates.dailyEvents.mealsHad {
            for food in meal.foodItems {
                totalProtienConsumed += food.protein
            }
        }
        return totalProtienConsumed
    }
    
    var carbsConsumed: Double {
        var totalCarbsConsumed: Double = .zero
        for meal in self.appStates.dailyEvents.mealsHad {
            for food in meal.foodItems {
                totalCarbsConsumed += food.protein
            }
        }
        return totalCarbsConsumed
    }
    
    var fatsConsumed: Double {
        var totalFatsConsumed: Double = .zero
        for meal in self.appStates.dailyEvents.mealsHad {
            for food in meal.foodItems {
                totalFatsConsumed += food.protein
            }
        }
        return totalFatsConsumed
    }
    
    var protienProgressDecimal: Double {
        let e = Double(self.protienConsumed / self.appStates.dailyNeeds.dailyProtien)
        return e > 1 ? 1 : e
    }
    
    var carbsProgressDecimal: Double {
        let e = Double(self.carbsConsumed / self.appStates.dailyNeeds.dailyCarbs)
        return e > 1 ? 1 : e
    }
    
    var fatsProgressDecimal: Double {
        let e = Double(self.fatsConsumed / self.appStates.dailyNeeds.dailyFats)
        return e > 1 ? 1 : e
    }
    var body: some View {
        VStack {
            Text("Macros")
                .font(.system(size: 20, weight: .light, design: .rounded))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // MARK: Protein heading
            Text("Protien")
                .font(.system(size: 15, weight: .light, design: .rounded))
                .foregroundStyle(.white.opacity(0.5))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 10)
            
            // MARK: Protein loading bar
            GeometryReader { geometry in
                HStack {
                    
                    // MARK: actual loading bar
                    HStack {
                        
                    }
                    .frame(maxHeight: .infinity)
                    .frame(width: geometry.size.width * self.protienProgressDecimal)
                    .background(ApplicationLinearGradient.greenGradient)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 40)
                .background(ApplicationLinearGradient.greenGradient.opacity(0.25))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay {
                    HStack {
                        
                        Text(String(format: "%.fg", self.protienConsumed))
                            .font(.custom(ApplicationFonts.oswaldRegular, size: 18))
                            .foregroundStyle(.white)
                        Spacer()
                        Text(String(format: "%.fg", self.appStates.dailyNeeds.dailyProtien))
                            .font(.custom(ApplicationFonts.oswaldRegular, size: 18))
                            .foregroundStyle(.white.opacity(0.5))
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal, 15)
                }
                
                
            }
            .frame(height: 35)
            
            
             // MARK: Carbs heading
            Text("Carbs")
                .font(.system(size: 15, weight: .light, design: .rounded))
                .foregroundStyle(.white.opacity(0.5))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 10)
            
            
            // MARK: Carbs loading bar
            GeometryReader { geometry in
                HStack {
                    
                    // MARK: actual loading bar
                    HStack {
                        
                    }
                    .frame(maxHeight: .infinity)
                    .frame(width: geometry.size.width * self.carbsProgressDecimal)
                    .background(ApplicationLinearGradient.brownGradient)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 40)
                .background(ApplicationLinearGradient.brownGradient.opacity(0.25))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay {
                    HStack {
                        Text(String(format: "%.fg", self.carbsConsumed))
                            .font(.custom(ApplicationFonts.oswaldRegular, size: 18))
                            .foregroundStyle(.white)
                        Spacer()
                        Text(String(format: "%.fg", self.appStates.dailyNeeds.dailyCarbs))
                            .font(.custom(ApplicationFonts.oswaldRegular, size: 18))
                            .foregroundStyle(.white.opacity(0.5))
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal, 15)
                }
                
                
            }
            .frame(height: 35)
            
            
            // MARK: Fats heading
            Text("Fats")
                .font(.system(size: 15, weight: .light, design: .rounded))
                .foregroundStyle(.white.opacity(0.5))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 10)
            
            
            
            // MARK: Fats loading bar
            GeometryReader { geometry in
                HStack {
                    
                    // MARK: actual loading bar
                    HStack {
                        
                    }
                    .frame(maxHeight: .infinity)
                    .frame(width: geometry.size.width * self.fatsProgressDecimal)
                    .background(ApplicationLinearGradient.goldenGradient)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 40)
                .background(ApplicationLinearGradient.goldenGradient.opacity(0.25))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay {
                    HStack {
                        
                        Text(String(format: "%.fg", self.fatsConsumed))
                            .font(.custom(ApplicationFonts.oswaldRegular, size: 18))
                            .foregroundStyle(.white)
                        
                        Spacer()
                        
                        Text(String(format: "%.fg", self.appStates.dailyNeeds.dailyFats))
                            .font(.custom(ApplicationFonts.oswaldRegular, size: 18))
                            .foregroundStyle(.white.opacity(0.5))
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal, 15)
                }
                
                
            }
            .frame(height: 45)
        }
        .frame(maxWidth: .infinity)
        .padding(15)
        .background(.darkBG.opacity(0.54))
        .overlay {
            defaultShape
                .stroke(.white.opacity(0.18))
        }
        .clipShape(defaultShape)
    }
}

