import SwiftUI

struct FoodViewCard: View {
    
    var food: Food_t
    
    var body: some View {
        ZStack {
            
            
            // MARK: Background image view
            HStack {
                Image(self.food.foodImage)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .offset(y: 10)
                    .opacity(0.25)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)

            
            // MARK: Content View
            VStack(spacing: 5) {
                Text(self.food.foodName)
                    .font(.custom(ApplicationFonts.oswaldRegular, size: 15))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(String(format: "🥦 %.f kCal", self.food.calories))
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(.white.opacity(0.06))
                    .overlay {
                        Capsule()
                            .stroke(.white.opacity(0.18))
                    }
                    .clipShape(Capsule())
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 90)
        .background(.darkBG.opacity(0.54))
        .overlay {
            defaultShape
                .stroke(.white.opacity(0.18))
        }
        .clipShape(defaultShape)
        .overlay {
            HStack {
               
                // MARK: Protein
                HStack(spacing: 5) {
                    Text(String(format: "%.f 🍖", self.food.protein))
                        .font(.custom(ApplicationFonts.oswaldRegular, size: 20))
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 8)
                .background(.darkBG.opacity(0.54))
                .background(AppBackgroundBlur(radius: 100, opaque: true))
                .overlay {
                    defaultShape
                        .stroke(.white.opacity(0.18))
                }
                .clipShape(defaultShape)
                
                // MARK: Carbs
                HStack(spacing: 5) {
                    Text(String(format: "%.f 🍞", self.food.carbs))
                        .font(.custom(ApplicationFonts.oswaldRegular, size: 20))
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 8)
                .background(.darkBG.opacity(0.54))
                .background(AppBackgroundBlur(radius: 100, opaque: true))
                .overlay {
                    defaultShape
                        .stroke(.white.opacity(0.18))
                }
                .clipShape(defaultShape)
                
                // MARK: Navigation button
                Image(systemName: "chevron.right")
                    .scaleEffect(0.75)
                    .foregroundStyle(.white.opacity(0.75))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
            .padding(25)
        }
        
    }
}

