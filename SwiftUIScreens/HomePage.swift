//
//  HomePage.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 19/01/25.
//

import SwiftUI

struct HomePage: View {
    @State var currentPage: Int = 0
    var body: some View {
        VStack {
            if currentPage == 0 {
                HomePageStruct(currentPage: $currentPage)
            } else if currentPage == 1 {
                
            } else if currentPage == 2 {
                CoachPage()
            } else if currentPage == 3 {
                
            } else {
//                ProfileView(currentPage_t: $currentPage)
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("DarkBG"), .black]), startPoint: UnitPoint(x: 0.5, y: 0.1), endPoint: UnitPoint(x: 0.5, y:1.6))
        )
    }
}


struct HomePageStruct: View {
    
    @Binding var currentPage: Int
    var body: some View {
        ZStack {
            PageHeader(pageHeaderTitle: "Home")
            ScrollView {
                VStack(spacing: 12) {
                    HomePageStepCounter(currentStepCount: 8000, goalStepCount: 15000)
                    HomePageCalories(caloriesConsumed: 1900, caloriesBurned: 195, totalCalories: 2500)
                    HomePageHydrationCounter(hydrationCount: 500, increaseCount: 250)
                    
                    SecondaryHeading(title: "Agenda Today")
                    AgendaTodayList()
                    
                    
                    SecondaryHeading(title: "Recent Activities")
                    RecentActivitiesTwinButton()
                    
                }
                .padding(.top, 100)
                .padding(.bottom, 400)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            PageNavigationBar(currentPage_t: $currentPage, currentPage: "Home")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("DarkBG"), .black]), startPoint: UnitPoint(x: 0.5, y: 0.1), endPoint: UnitPoint(x: 0.5, y:1.6))
        )
    }
}


#Preview {
    HomePage()
}
