//
//  ScannedFoodDetailScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 22/04/25.
//

import SwiftUI

struct ScannedFoodDetailScreen: View {
    struct ScannedFood_t: Codable {
        var foodName: String
        var foodDescription: String
        var foodQuantity: Double
        var calories: Double
        var protein: Double
        var carbs: Double
        var fats: Double
        var caloriesPerGram: Double
        var foodType: Extras.FoodType
        var foodImage: String
        var protienPerGram: Double
        var carbsPerGram: Double
        var fatsPerGram: Double
        
        enum CodingKeys: String, CodingKey {
            case foodName
            case foodDescription
            case foodQuantity
            case calories
            case protein
            case carbs
            case fats
            case caloriesPerGram = "calories_per_gram"
            case foodType
            case foodImage
            case protienPerGram
            case carbsPerGram
            case fatsPerGram
        }
    }
    
    func cleanResponse(jsonString: String) -> String {
        if jsonString.hasPrefix("```json") {
            let index = jsonString.index(jsonString.startIndex, offsetBy: 8) // 5 chars to skip "json:"
            let toIndex = jsonString.index(jsonString.endIndex, offsetBy: -5)
            return String(jsonString[index...toIndex]).trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return jsonString
    }
    
    @EnvironmentObject var appStates: ApplicationStates
    
    @State var foodItem: Optional<Food_t> = nil
    @State var scannedFoodItem: Optional<ScannedFood_t> = nil
    @State var foodQuantity: Double = .zero
    
    var body: some View {
        ScreenBuilder {
            
            
            AccentPageHeader_NoAction(pageHeaderTitle: "Scanned Food") {
                self.appStates.showScannedFoodDetailScreen = false
            }
            
            BottomBlur()
                .offset(y: UIScreen.main.bounds.height - (55 * 2.1))
                .transition(.offset(y: 400))
            
            
            // MARK: Bottom button
            
            VStack {
                Text("Add Food")
                    .foregroundStyle(.white)
                    .font(.system(size: 13 , weight: .medium, design: .rounded))
                    .transition(.blurReplace)
                
            }
            .frame(width: BOTTOM_BUTTON_WIDTH, height: BOTTOM_BUTTON_HEIGHT)
            .background(ApplicationLinearGradient.redGradient)
            .clipShape(defaultShape)
            .offset(y: BOTTOM_BUTTON_OFFSET)
            .zIndex(9999)
            .ignoresSafeArea()
            
            
            
            ScrollContentView {
                VStack {
                    
                    
                    if let food = self.foodItem {
                        AsyncImage(url: URL(string: food.foodImage)) { phase in
                            switch phase {
                            case .empty:
//                                Image(systemName: "photo.badge.exclamationmark.fill")
//                                    .resizable()
//                                    .frame(width: 80, height: 60)
//                                    .foregroundStyle(.white.opacity(0.25))
                                ProgressView()
                                    .tint(.white)
                            case .success(let image):
                                image
                                    .resizable()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            case .failure:
                                Image(systemName: "exclamationmark.icloud.fill")
                                    .resizable()
                                    .frame(width: 80, height: 60)
                                    .foregroundStyle(.white.opacity(0.25))
                            @unknown default:
                                Text("No Such Image Exists.")
                                    .font(.system(size: 15, weight: .medium, design: .rounded))
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .overlay {
                    defaultShape
                        .stroke(.white.opacity(0.08))
                }
                .background(.darkBG.opacity(0.54), in: defaultShape)
               
                if let food = self.foodItem, let searchedFood = self.scannedFoodItem {
                    SecondaryHeading(title: food.foodName)
                        .padding(.top)
                    
                    Text(food.foodDescription)
                        .bottomDialogBoxBodyText()
                        .padding(.horizontal, 10)
                    
                    SecondaryHeading(title: "Nutirional Values")
                        .padding(.top, 25)
                    
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 15), GridItem(.flexible(), spacing: 15)], alignment: .leading) {
                        MacroStyleCardMaxWidth(text: String(format: "%.fg Protein 🍖", searchedFood.protienPerGram * self.foodQuantity))
                        MacroStyleCardMaxWidth(text: String(format: "%.fg Carbs 🍞", searchedFood.carbsPerGram * self.foodQuantity))
                        MacroStyleCardMaxWidth(text: String(format: "%.fg Fats 🌽", searchedFood.fatsPerGram * self.foodQuantity))
                        MacroStyleCardMaxWidth(text: String(format: "%.fg kCal 🥦", searchedFood.caloriesPerGram * self.foodQuantity))

                    }
                    
                    
                    SecondaryHeading(title: "Adjust Your Intake")
                        .padding(.top, 25)
                    
                    Text("Please adjust your food macro intake, the ai would have analyzed the quantity of food, but if you think this is incorrect please change it below.")
                        .bottomDialogBoxBodyText()
                        .padding(.horizontal, 10)
                    
                    VStack {
                        Text(String(format: "Food Quantity: %.1fg", self.foodQuantity))
                            .font(.custom(ApplicationFonts.oswaldRegular, size: 15))
                            .foregroundStyle(.white)
                            .takeMaxWidthLeading()
                            .contentTransition(.numericText(value: self.foodQuantity))
                            .animation(.snappy, value: self.foodQuantity)
                        
                        Slider(value: self.$foodQuantity, in: 1...1000)
                            .padding(.horizontal, 5)
                            .padding(.top, 5)
                        
                        CustomPrecisionStepper(value: self.$foodQuantity)
                        
                        SimpleButton(content: {
                           Text("Set To Default")
                                .font(.system(size: 13, weight: .medium, design: .rounded))
                                .foregroundStyle(.white)
                        }, backgroundLinearGradient: ApplicationLinearGradient.blueGradientInverted , some: {
                            withAnimation {
                                self.foodQuantity = self.foodItem!.foodQuantity
                            }
                        })
                            
                    }
                    .padding(15)
                    .background(.darkBG.opacity(0.54))
                    .overlay {
                        defaultShape
                            .stroke(.white.opacity(0.18))
                    }
                    .clipShape(defaultShape)
                }
                
                    
                
            }
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        }
        .sensoryFeedback(.impact, trigger: self.foodQuantity)
        .onAppear {
            let foodDataJson = self.cleanResponse(jsonString: self.appStates.scannedFoodDetail)
            print("--------")
            print(foodDataJson)
            let decoder = JSONDecoder()
            
            if let foodJsonData = foodDataJson.data(using: .utf8) {
                do {
                    let scannedFoodItem = try decoder.decode(ScannedFood_t.self, from: foodJsonData)
                    self.scannedFoodItem = scannedFoodItem
                    self.foodItem = .init(foodName: scannedFoodItem.foodName, foodDescription: scannedFoodItem.foodDescription, foodQuantity: scannedFoodItem.foodQuantity, calories: scannedFoodItem.calories, foodImage: "", foodType: .clean, protein: scannedFoodItem.protein, carbs: scannedFoodItem.carbs, fats: scannedFoodItem.fats)
                    
                    self.foodQuantity = scannedFoodItem.foodQuantity
                } catch {
                    print(error)
                }
            }
            
        }
    }
}

#Preview {
    ScannedFoodDetailScreen()
}
