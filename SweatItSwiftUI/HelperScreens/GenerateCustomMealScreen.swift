//
//  GenerateCustomMealScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 05/06/25.
//

import SwiftUI

struct FoodTemplate {
    var id: String = UUID().uuidString
    var foodName: String
    var foodDescription: String
    var quantity: String
}

struct GenerateCustomMealScreen: View {
    
    @State var foodTemplates: Array<FoodTemplate> = []
    
    
    @State var isEmptyError: Bool = false
    @State var isLessWordsError: Bool = false
    
    @State var isMealLoading: Bool = false
    
    @State var isArrayEmpty: Bool = false
   
    func genrateMeal() -> Void {
        print("Button tapped")
        if self.foodTemplates.isEmpty {
            withAnimation {
                self.isArrayEmpty = true
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    withAnimation {
                        self.isArrayEmpty = false
                    }
                }
            }
            return
        }
    }
    var body: some View {
        ScreenBuilder {
            
            if self.isArrayEmpty {
                Text("Lagish ho raha hai")
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(10)
                    .padding(.horizontal, 10)
                    .background(ApplicationLinearGradient.redGradient, in: Capsule())
                    .zIndex(99999)
                    .transition(.offset(y: -300))
            }
            
            if self.isEmptyError {
                Text("Empty Text Fields")
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(10)
                    .padding(.horizontal, 10)
                    .background(ApplicationLinearGradient.redGradient, in: Capsule())
                    .zIndex(99999)
                    .transition(.offset(y: -300))
            }
           
            if self.isLessWordsError {
                Text("Food Name should be greater thane 2 words.")
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(10)
                    .padding(.horizontal, 10)
                    .background(ApplicationLinearGradient.redGradient, in: Capsule())
                    .zIndex(99999)
                    .transition(.offset(y: -300))
            }
           
            AccentPageHeader_GenerateCustomMealScreen(pageHeaderTitle: "Generate Meals")
            
            ScrollContentView {
                
                ForEach(self.foodTemplates, id: \.id) { foodTemplate in
                    
                }
                FoodTemplateInputCard(foodTemplates: self.$foodTemplates, isEmptyError: self.$isEmptyError, isLessWordsError: self.$isLessWordsError)
                    .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            }
            
            HStack {
                BottomBluredButton(text: "Generate Meal", background: ApplicationLinearGradient.redGradient) {
                    self.genrateMeal()
                }
                .offset(y: BOTTOM_BUTTON_OFFSET - 40)
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            }
            .onTapGesture {
                self.genrateMeal()
            }
            .zIndex(9999)

            BottomBlur()
                .offset(y: UIScreen.main.bounds.height - (55 * 2.1))
                .transition(.offset(y: 400))
        }
    }
}

struct FoodTemplateInputCard: View {
    
    @Binding var foodTemplates: Array<FoodTemplate>
    
    @State var currentFoodName: String = ""
    @State var currentFoodDescription: String = "Description"
    @State var currentFoodQuantity: String = ""
    @State var currentSelectedFoodType: Extras.FoodType = .clean
    
    @Binding var isEmptyError: Bool
    @Binding var isLessWordsError: Bool
    
    
    func addFoodTemplate() {
        if currentFoodName.isEmpty || currentFoodQuantity.isEmpty {
            withAnimation {
                self.isEmptyError = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        self.isEmptyError = false
                    }
                }
            }
            return
        }
        
        if currentFoodName.count < 3 {
            withAnimation {
                self.isLessWordsError = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        self.isLessWordsError = false
                    }
                }
            }
            return
        }
        
        
        withAnimation {
            self.foodTemplates.append(.init(foodName: self.currentFoodName, foodDescription: self.currentFoodDescription, quantity: self.currentFoodQuantity))
            self.currentFoodName = ""
            self.currentFoodDescription = "Description"
            self.currentFoodQuantity = ""
            self.currentSelectedFoodType = .clean
        }
    }
    
    var body: some View {
        VStack {
            
            // MARK: Food name and quantity
            CustomTextField(searchText: self.$currentFoodName, placeholder: "Food Name")
            CustomTextField(searchText: self.$currentFoodQuantity, placeholder: "Food Quantity (g or ml)")
            
            
            // MARK: Food description (optional)
            TextEditor(text: self.$currentFoodDescription)
                .font(.system(size: 13))
                .foregroundStyle(.white.opacity(0.5))
                .scrollContentBackground(.hidden)
                .frame(maxWidth: .infinity, minHeight: 100)
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(.darkBG.opacity(0.54), in: defaultShape)
                .overlay {
                    defaultShape
                        .stroke(.white.opacity(0.08), lineWidth: 1)
                }
            
            CustomDropdown(imageName: "fork.knife.circle.fill", showValue: self.currentSelectedFoodType.rawValue) {
                VStack {
                    ForEach(Extras.FoodType.allCases, id: \.self) { foodType in
                        Text(foodType.rawValue)
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 35)
                            .background(self.currentSelectedFoodType == foodType ? ApplicationLinearGradient.blueGradientInverted : ApplicationLinearGradient.whiteSameGradientWithOpacityPoint8)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .onTapGesture {
                                withAnimation {
                                    self.currentSelectedFoodType = foodType
                                }
                            }
                    }
                }
                .padding(.bottom)
            }
            
            BottomBluredButton(text: "Add Food Item", background: ApplicationLinearGradient.thanosGradient) {
                self.addFoodTemplate()
            }
            .padding(.top, 10)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.darkBG.opacity(0.54), in: defaultShape)
        .overlay {
            defaultShape
                .stroke(.white.opacity(0.08), lineWidth: 1)
        }
        .sensoryFeedback(.impact, trigger: self.currentSelectedFoodType)
    }
}

struct AccentPageHeader_GenerateCustomMealScreen: View {
    
    var pageHeaderTitle: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack {
            ZStack {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.white)
                    .scaleEffect(0.9)
                    .padding(20)
                    .background(.darkBG.opacity(0.001))
                    .onTapGesture {
                        self.dismiss()
                    }
                    .offset(x: -160, y: 15)
                
                Text(pageHeaderTitle)
                    .font(.system(size: 23, weight: .light, design: .rounded))
                    .foregroundStyle(.white)
                    .offset(y: 15)
               
                Image(systemName: "keyboard.chevron.compact.down.fill")
                    .foregroundStyle(.white)
                    .scaleEffect(0.9)
                    .padding(20)
                    .background(.darkBG.opacity(0.001))
                    .onTapGesture {
                        ApplicationHelper.dismissKeyboard()
                    }
                    .offset(x: 155, y: 15)
                
            }
            .offset(y: 25)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 137)
        .background(AppBackgroundBlur(radius: 50, opaque: true))
        .background(Color("DarkBG").opacity(0.55))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white.opacity(0.18))
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .offset(y: -85)
        .zIndex(100)
        
    }
}

#Preview {
    GenerateCustomMealScreen()
}
