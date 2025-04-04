//
//  FoodTypeQuestionnaireScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 22/03/25.
//

import SwiftUI

struct FoodTypeQuestionnaireScreen: View {
    @EnvironmentObject var appStates: ApplicationStates
    
    @Binding var showAddAnnualIncomeTopSheet: Bool
    
    @Binding var showSelectRegionScreen: Bool
    @Binding var showSelectAlergiesScreen: Bool
    @Binding var selectedFoodAlergies: Array<Extras.FoodAllergy>
    @Binding var selectedRegion: String

    enum BudgetSelectionType: String, CaseIterable {
        case weekly = "Weekly", monthly = "Monthly"
    }
    
    @StateObject var annualIncomes = ApplicationConstants()
    
    @State var showFoodTypeDropDown: Bool = false
    @State var currentSelectedFoodType: Extras.UserFoodType = .none
    @State var currentSelectedBudgetType: BudgetSelectionType = .weekly
    @State var currentSelectedAnnualIncom: ClosedRange<Int> = .init(uncheckedBounds: (0, 0))
    @State var budget: Double = 1000
    
    func midpoint<T: BinaryInteger>(_ range: ClosedRange<T>) -> Double {
        return Double(range.lowerBound + range.upperBound) / 2.0
    }
   
    func changeSliderBasedOnAnnualIncome() -> Void {
        
        if self.currentSelectedBudgetType == .weekly {
            let something = Double((self.midpoint(self.currentSelectedAnnualIncom) * 0.12) / 52)
            withAnimation(.snappy(duration: 1)) {
                self.budget = Double(something * 100000)
            }
        } else {
            let something = Double((self.midpoint(self.currentSelectedAnnualIncom) * 0.12) / 12)
            withAnimation(.snappy(duration: 1)) {
                self.budget = Double(something * 100000)
            }
        }
        
        print(self.budget)
    }
    
    
    
    var body: some View {
        VStack {
            
            ScrollView(showsIndicators: false) {
                VStack {
                    Text("Choose options that satisfy your taste in food items, based on this information all, the app will recommend you food items.")
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundStyle(.white.opacity(0.5))
                        .padding(.horizontal, 3)
                        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                    
                    SectionHeader(text: "Regional Settings")
                        .padding(.top, 25)
                        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                    
                    
                    // MARK: Select region button
                    HStack(spacing: 20) {
                        Image(systemName: "flag.fill")
                            .foregroundStyle(self.selectedRegion.isEmpty ? .white.opacity(0.5) : .white)
                        
                        Text(self.selectedRegion.isEmpty ? "Select Region" : self.selectedRegion)
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                            .foregroundStyle(self.selectedRegion.isEmpty ? .white.opacity(0.5) : .white)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundStyle(self.selectedRegion.isEmpty ? .white.opacity(0.5) : .white)
                            .scaleEffect(0.75)
                    }
                    .applicationDropDownButton(self.selectedRegion.isEmpty ? ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf : ApplicationLinearGradient.blueGradientInverted)
                    .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                    .onTapGesture {
                        withAnimation(.smooth(duration: 0.4)) {
                            self.showSelectRegionScreen = true
                        }
                    }
                    
                    
                    
                    // MARK: Select veg or non veg
                    SectionHeader(text: "Choose your side")
                        .padding(.top, 25)
                        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                    
                    VStack {
                        
                        HStack(spacing: 25) {
                            Image(systemName: "fork.knife")
                                .foregroundStyle(.white.opacity(0.5))
                            
                            Text("Food Type")
                                .font(.system(size: 15, weight: .regular, design: .rounded))
                                .foregroundStyle(.white.opacity(0.5))
                            
                            Spacer()
                            
                            Image(systemName: "chevron.down")
                                .foregroundStyle(.white.opacity(0.5))
                                .scaleEffect(0.75)
                                .rotationEffect(.degrees(self.showFoodTypeDropDown ? -90 : 0))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.white.opacity(0.001))
                        .padding(.vertical, self.showFoodTypeDropDown ? 12 : 0)
                        .onTapGesture {
                            withAnimation {
                                self.showFoodTypeDropDown.toggle()
                            }
                        }
                        
                        if self.showFoodTypeDropDown {
                            
                            VStack {
                                ForEach(Extras.UserFoodType.allCases, id: \.self) { foodType in
                                    if foodType != .none {
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
                                                    self.showFoodTypeDropDown = false
                                                }
                                            }
                                    }
                                }
                            }
                            .padding(.bottom)
                            .transition(.offset(y: UIScreen.main.bounds.height / 3).combined(with: .blurReplace))
                            .animation(.smooth(duration: 1), value: self.showFoodTypeDropDown)
                        }
                        
                        
                    }
                    .applicationDropDownButton()
                    .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                    
                    
                    
                    
                    
                    SectionHeader(text: "Food Budget")
                        .padding(.top, 25)
                        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                    
                    
                    
                    // MARK: Fuud budget
                    HStack {
                        ForEach(BudgetSelectionType.allCases, id: \.self) { option in
                            
                            HStack {
                                
                                switch option {
                                case .weekly:
                                    Image(systemName: "7.circle")
                                        .foregroundStyle(self.currentSelectedBudgetType == option ? .white : .white.opacity(0.5))
                                case .monthly:
                                    Image(systemName: "calendar")
                                        .foregroundStyle(self.currentSelectedBudgetType == option ? .white : .white.opacity(0.5))
                                }
                                
                                Text(option.rawValue)
                                    .font(.system(size: 13, weight: .medium, design: .rounded))
                                    .foregroundStyle(self.currentSelectedBudgetType == option ? .white : .white.opacity(0.5))
                            }
                            .applicationDropDownButton(self.currentSelectedBudgetType == option ? ApplicationLinearGradient.blueGradientInverted : ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf, height: 40)
                            .onTapGesture {
                                withAnimation {
                                    self.currentSelectedBudgetType = option
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                    
                    
                    
                    
                    
                    
                    // MARK: Annual incom
                    SectionHeader(text: "Choose Annual Income")
                        .padding(.top, 25)
                        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(self.annualIncomes.annualIncoms, id: \.self) { incomLevel in
                                HStack{
                                    Text(String(incomLevel.lowerBound) + "-" + String(incomLevel.upperBound) + " LPA")
                                        .font(.system(size: 13, weight: .medium, design: .rounded))
                                        .foregroundStyle(self.currentSelectedAnnualIncom == incomLevel ? .white : .white.opacity(0.5))
                                }
                                .applicationDropDownButton(self.currentSelectedAnnualIncom == incomLevel ? ApplicationLinearGradient.blueGradientInverted : ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf, height: 40)
                                .onTapGesture {
                                    withAnimation {
                                        self.currentSelectedAnnualIncom = incomLevel
                                    }
                                }
                            }
                            
                            HStack {
                                Image(systemName: "plus")
                                    .foregroundStyle(.white.opacity(0.75))
                                    .frame(width: 40, height: 45)
                                    .overlay {
                                        Circle()
                                            .stroke(.white.opacity(0.18))
                                    }
                                    .background(ApplicationLinearGradient.blueGradientInverted, in: Circle())
                                    .onTapGesture {
                                        withAnimation {
                                            self.showAddAnnualIncomeTopSheet = true
                                        }
                                    }
                            }
                        }
                        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                        
                    }
                   
                    SectionHeader(text: "Choose Budget")
                        .padding(.top, 25)
                        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                    
                    // MARK: Budget Slider
                    VStack(spacing: 15) {
                        Slider(value: self.$budget, in: 1000...20000)
                            .tint(ApplicationLinearGradient.blueGradientInverted)
                        
                        
                        
                        HStack {
                            
                            
                            Text(self.currentSelectedBudgetType == .monthly ? "Monthly:" : "Weekly:")
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                                .foregroundStyle(.white.opacity(0.5))
                            
                            Text(String(format: "%.f ₹", self.budget))
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                                .foregroundStyle(.white.opacity(0.5))
                                .contentTransition(.numericText(value: self.budget))
                                .animation(.snappy, value: self.budget)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.vertical)
                    .applicationDropDownButton()
                    .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                    
                    
                    
                    
                    
                    
                    // MARK: Alergies button
                    SectionHeader(text: "Algergies")
                        .padding(.top, 25)
                        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                    
                    
                    HStack(spacing: 20) {
                        Image(systemName: "allergens")
                            .foregroundStyle(.white.opacity(0.5))
                        
                        Text("Alergies")
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                            .foregroundStyle(.white.opacity(0.5))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.white.opacity(0.5))
                            .scaleEffect(0.75)
                        
                    }
                    .applicationDropDownButton()
                    .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                    .onTapGesture {
                        withAnimation(.smooth(duration: 0.4)) {
                            self.showSelectAlergiesScreen = true
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(self.selectedFoodAlergies, id: \.self) { alergies in
                                Text(alergies.rawValue)
                                    .font(.system(size: 15, weight: .regular, design: .rounded))
                                    .foregroundStyle(.white)
                                    .frame(height: 35)
                                    .padding(.horizontal)
                                    .background(ApplicationLinearGradient.blueGradientInverted)
                                    .overlay {
                                        defaultShape
                                            .stroke(.white.opacity(0.18))
                                    }
                                    .clipShape(defaultShape)
                            }
                            
                        }
                        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                    }
                }
                .padding(.vertical, ApplicationPadding.mainScreenVerticalPadding)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .onChange(of: self.currentSelectedAnnualIncom) {
            self.changeSliderBasedOnAnnualIncome()
        }
        .onChange(of: self.currentSelectedBudgetType) {
            self.changeSliderBasedOnAnnualIncome()
        }
        .onChange(of: self.currentSelectedFoodType) {
            self.appStates.userData.foodType = self.currentSelectedFoodType
        }
        .onChange(of: self.selectedFoodAlergies) {
            self.appStates.userData.alergies = self.selectedFoodAlergies
        }
        .onChange(of: self.selectedRegion) {
            self.appStates.userData.region = self.selectedRegion
        }
        .sensoryFeedback(.impact, trigger: self.budget)
        .sensoryFeedback(.impact, trigger: self.currentSelectedBudgetType)
    }
}
