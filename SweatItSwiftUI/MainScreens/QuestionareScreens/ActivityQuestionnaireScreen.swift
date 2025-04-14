//
//  ActivityQuestionnaireScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 22/03/25.
//

import SwiftUI

struct ActivityQuestionnaireScreen: View {
    @EnvironmentObject var appStates: ApplicationStates
    
    enum ActivityScreenState: String, CaseIterable, Codable {
        case daysInWeek = "Days In Week", hoursEachDay = "Hours Each Day"
    }
    
    
    @State var selectedHour: Int = 0
    @State var currentSelectedState: ActivityScreenState = .daysInWeek
    @State var currentSelectedDays: Array<String> = ["Mon", "Wed"]
    
    var daysInWeek: Array<String> = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    let dialText: Array<Int> = [1,2,3,4,5,6,7,8,9,10,11,12]
    @State var hoursADay: Double = 0.1
    
    var body: some View {
        VStack {
            Text("Please select how many hours you are active through the week eg. ( Use the sliders below )")
                .font(.system(size: 12, weight: .regular, design: .rounded))
                .foregroundStyle(.white.opacity(0.5))
                .takeMaxWidthLeading()
            
           
            SectionHeader(text: "Choose Option")
                .padding(.top, 25)
            HStack {
                ForEach(ActivityScreenState.allCases, id: \.self) { type_t in
                    HStack {
                        Text(type_t.rawValue)
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                            .foregroundStyle(self.currentSelectedState == type_t ? .white : .white.opacity(0.5))
                            .frame(maxWidth: .infinity)
                        
                    }
                    .applicationDropDownButton(self.currentSelectedState == type_t ? ApplicationLinearGradient.blueGradientInverted : ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf, height: 40)
                    .onTapGesture {
                        withAnimation {
                            self.currentSelectedState = type_t
                        }
                    }
                }
            }
            
            
            HStack {
                    
                VStack {
                    Text(String(self.currentSelectedDays.count))
                        .font(.system(size: 35, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .contentTransition(.numericText(value: Double(self.currentSelectedDays.count)))
                        .animation(.snappy, value: self.currentSelectedDays.count)
                    
                    Text("Days a week")
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        
                    
                }
                .applicationDropDownButton(height: 85)
                
                VStack {
                    Text(String(format: "%.1f", self.hoursADay))
                        .font(.system(size: 35, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .contentTransition(.numericText(value: self.hoursADay))
                        .animation(.snappy, value: self.hoursADay)
                    
                    Text("Hours a day")
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                    
                }
                .applicationDropDownButton(height: 85)
                
                
                
              
            }
            .frame(maxWidth: .infinity)
            
           
            
            if self.currentSelectedState == .daysInWeek {
                SectionHeader(text: "Choose days")
                    .padding(.top, 25)
                
                HStack {
                    ForEach(self.daysInWeek, id: \.self) { day in
                        VStack {
                            Text(day.split(separator: "").first!)
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                                .foregroundStyle(self.currentSelectedDays.contains(day) ? .white : .white.opacity(0.5))
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(self.currentSelectedDays.contains(day) ? ApplicationLinearGradient.blueGradientInverted : ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf)
                        .overlay {
                            defaultShape
                                .stroke(.white.opacity(0.18))
                            
                        }
                        .clipShape(defaultShape)
                        .onTapGesture {
                            withAnimation {
                                if self.currentSelectedDays.contains(day) {
                                    self.currentSelectedDays.removeAll(where: { $0 == day })
                                } else {
                                    self.currentSelectedDays.append(day)
                                }
                            }
                        }
                    }
                }
                .transition(.blurReplace)
            } else {
                
                SectionHeader(text: "Slide your choice")
                    .padding(.top, 25)
                
                Slider(value: self.$hoursADay, in: 0...7)
                    .tint(ApplicationLinearGradient.blueGradientInverted)
                HStack {
                   
                    Text("1")
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .foregroundStyle(.white.opacity(0.5))
                   Spacer()
                    
                    Text("7")
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .foregroundStyle(.white.opacity(0.5))
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                    
            }
            
            
        }
        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
        .padding(.vertical, ApplicationPadding.mainScreenVerticalPadding)
        .onChange(of: self.currentSelectedDays) {
            self.appStates.userData.activeDays = self.currentSelectedDays
        }
        .onChange(of: self.hoursADay) {
            self.appStates.userData.activeHoursADay = self.hoursADay
        }
        .sensoryFeedback(.impact, trigger: String(format: "%.1f", self.hoursADay))
        .sensoryFeedback(.impact, trigger: self.currentSelectedDays.count)
        .sensoryFeedback(.impact, trigger: self.currentSelectedState)
    }
}


