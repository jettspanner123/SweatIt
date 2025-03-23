//
//  SelectAlergiesScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 23/03/25.
//

import SwiftUI

struct SelectAlergiesScreen: View {
    
    @Binding var selectedAlergies: Array<Extras.FoodAllergy>
    var alergiesOption: Array<Extras.FoodAllergy> = Array(Extras.FoodAllergy.allCases)
    
    var body: some View {
        ScreenBuilder {
            
            AccentPageHeader(pageHeaderTitle: "Select Alergies")
            
            ScrollContentView {
                
                if !self.selectedAlergies.isEmpty {
                    SectionHeader(text: "Current Selected Alergies")
                        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                        .transition(.offset(y: -UIScreen.main.bounds.height / 4).combined(with: .blurReplace))
                    
                    
                    
                    
                    // MARK: Upark ki scroll view hai jisme sare alergies show honge
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(self.selectedAlergies, id: \.self) { alergies in
                                HStack {
                                    Text(alergies.rawValue)
                                        .font(.system(size: 15, weight: .regular, design: .rounded))
                                        .foregroundStyle(.white)
                                    
                                    Image(systemName: "xmark")
                                        .foregroundStyle(.white.opacity(0.5))
                                        .scaleEffect(0.75)
                                    
                                }
                                .frame(height: 35)
                                .padding(.horizontal)
                                .background(ApplicationLinearGradient.blueGradientInverted)
                                .overlay {
                                    defaultShape
                                        .stroke(.white.opacity(0.18))
                                }
                                .clipShape(defaultShape)
                                .onTapGesture {
                                    self.selectedAlergies.remove(at: self.selectedAlergies.firstIndex(of: alergies)!)
                                }
                                
                            }
                        }
                        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                    }
                    .transition(.offset(y: -UIScreen.main.bounds.height / 4).combined(with: .blurReplace))
                    
                    
                    
                }
                
                
                
                
                // MARK: Render kar raha hu all the allergies that i have
                
                
                SectionHeader(text: "Choose your allergies")
                    .padding(.top, self.selectedAlergies.isEmpty ? 0 : 25)
                    .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                
                CustomList {
                    VStack {
                        ForEach(self.alergiesOption.indices, id: \.self) { index in
                            if !self.selectedAlergies.contains(self.alergiesOption[index]) {
                                Text(self.alergiesOption[index].rawValue)
                                    .font(.system(size: 15, weight: .regular, design: .rounded))
                                    .foregroundStyle(.white.opacity(0.5))
                                    .frame(height: 25)
                                    .takeMaxWidthLeading()
                                    .padding(.horizontal, 15)
                                    .background(.white.opacity(0.001))
                                    .onTapGesture {
                                        withAnimation {
                                            self.selectedAlergies.append(self.alergiesOption[index])
                                        }
                                    }
                                
                                if index != self.alergiesOption.count - 1 {
                                    CustomDivider()
                                }
                            }
                            
                        }
                    }
                }
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                
                
            }
        }
        .background(.blue)
    }
}
