//
//  AvgStepsPerWeek.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 25/03/25.
//

import SwiftUI


struct AvgStepsPerWeek: View {
    @EnvironmentObject var appStates: ApplicationStates
    
    
    func getReducedValue(_ value: Double, maxValue: Double = 1000) -> Double {
        return min(max(value / maxValue, 0), 1)
    }
    
    func calculatePercentage(value: Double, total: Double) -> Double {
        guard total != 0 else { return 0 } // Avoid division by zero
        return value / total
    }
    
    @State var weeklyStepsTaken: Dictionary<Date, Int> = [:]
    
    var avgStepsTaken: Int {
        if self.weeklyStepsTaken.isEmpty {
            return 0
        } else {
            return self.weeklyStepsTaken.reduce(0) { $0 + $1.value } / self.weeklyStepsTaken.count
        }
    }

    var body: some View {
        VStack {
            HStack(alignment: .bottom, spacing: 5) {
                Text("Avg Steps")
                    .font(.custom(ApplicationFonts.oswaldRegular, size: 25))
                    .foregroundStyle(.white.opacity(0.85))
                
                
                Spacer()
                
                Text("\(self.avgStepsTaken) / \(self.appStates.dailyNeeds.dailySteps)")
                    .font(.custom(ApplicationFonts.oswaldRegular, size: 20))
                    .foregroundStyle(.white.opacity(0.75))
                    .contentTransition(.numericText(value: Double(self.avgStepsTaken)))
                    .animation(.snappy, value: self.avgStepsTaken)
                
                
            }
            .takeMaxWidthLeading()
            
            
            Text("( per day )")
                .font(.custom(ApplicationFonts.oswaldRegular, size: 15))
                .foregroundStyle(.white.opacity(0.5))
                .offset(y: -5)
                .takeMaxWidthLeading()
            
            
           
            if !self.weeklyStepsTaken.isEmpty {
                GeometryReader {
                let readerSize = $0.size
                
                HStack {
                    ForEach(self.weeklyStepsTaken.sorted(by: >), id: \.key) { key, value in
                        let height = self.calculatePercentage(value: Double(value), total: 15000) * readerSize.height * 0.8
                        
                        HStack {
                            
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: height)
                        .background(.appBlueDark.opacity(self.getReducedValue(Double(value), maxValue: 15000) - 0.1), in: RoundedRectangle(cornerRadius: 8))
                        .frame(maxHeight: .infinity, alignment: .bottom)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            }
            
            HStack {
                ForEach(["M", "T", "W", "Th", "F", "Sa", "Su"], id: \.self) { day in
                    Text(day)
                        .font(.custom(ApplicationFonts.oswaldRegular, size: 15))
                        .foregroundStyle(.white.opacity(0.5))
                        .frame(maxWidth: .infinity)
                        .frame(height: 35)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.white.opacity(0.18))
                        }
                        .background(.appBlueDark.opacity(0.5), in: RoundedRectangle(cornerRadius: 8))
                }
            }
            }
        }
        .frame(maxWidth: .infinity, minHeight: self.weeklyStepsTaken.isEmpty ? 75 : 250, alignment: .topLeading)
        .padding()
        .background(ApplicationLinearGradient.blueGradient, in: defaultShape)
        .onAppear {
            Task {
                self.weeklyStepsTaken = try await ApplicationEndpoints.get.getWeeklySteps(forUserId: User.current.currentUser.id)
            }
        }
    }
}


