//
//  AvgStepsPerWeek.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 25/03/25.
//

import SwiftUI


struct AvgStepsPerWeek: View {
    
    
    func getReducedValue(_ value: Double, maxValue: Double = 1000) -> Double {
        return min(max(value / maxValue, 0), 1)
    }
    
    func calculatePercentage(value: Double, total: Double) -> Double {
        guard total != 0 else { return 0 } // Avoid division by zero
        return value / total
    }
    
    @State var weeklyData: Array<DailyEvents_t> = DailyEvents.current.weeklyEvents
    
    var avgStepsTaken: Int { return self.weeklyData.reduce(0) { $0 + $1.stepsTaken } / self.weeklyData.count}
    var body: some View {
        VStack {
            HStack(alignment: .bottom, spacing: 5) {
                Text("Avg Steps")
                    .font(.custom(ApplicationFonts.oswaldRegular, size: 25))
                    .foregroundStyle(.white.opacity(0.85))
                
                
                Spacer()
                
                Text("\(self.avgStepsTaken) / 15,000")
                    .font(.custom(ApplicationFonts.oswaldRegular, size: 20))
                    .foregroundStyle(.white.opacity(0.75))
                
                
            }
            .takeMaxWidthLeading()
            
            
            Text("( per day )")
                .font(.custom(ApplicationFonts.oswaldRegular, size: 15))
                .foregroundStyle(.white.opacity(0.5))
                .offset(y: -5)
                .takeMaxWidthLeading()
            
            
           
            GeometryReader {
                let readerSize = $0.size
                
                HStack {
                    ForEach(self.weeklyData, id: \.id) { dayData in
                        let height = self.calculatePercentage(value: Double(dayData.stepsTaken), total: 15000) * readerSize.height * 0.8
                        
                        HStack {
                            
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: height)
                        .background(.appBlueDark.opacity(self.getReducedValue(Double(dayData.stepsTaken), maxValue: 15000) - 0.1), in: RoundedRectangle(cornerRadius: 8))
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
        .frame(maxWidth: .infinity, minHeight: 250, alignment: .topLeading)
        .padding()
        .background(ApplicationLinearGradient.blueGradient, in: defaultShape)
    }
}


