//
//  AvgStepsThisWeekGraph.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 25/04/25.
//

import SwiftUI

struct WeeklyActivityGraph: View {
    
    @State var weeklyActivitySummary: Array<Date> = []
    var body: some View {
        HStack {
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .padding()
        .background(ApplicationLinearGradient.lavaGradient, in: defaultShape)
        .onAppear {
            Task {
                let temp_weeklyActivitySummary = try await ApplicationEndpoints.get.getWeeklyActivitySummary(forUserId: User.current.currentUser.id)
                withAnimation {
                    self.weeklyActivitySummary = temp_weeklyActivitySummary
                }
            }
        }
        
    }
}
