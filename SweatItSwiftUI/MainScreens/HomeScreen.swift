//
//  HomeScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 09/03/25.
//

import SwiftUI

struct HomeScreen: View {
    
    @State var AgendaToday: Array<Agenda_t> = Agenda.current.exampleAgendaList
    @State var RescentActivities: Array<Activity_t> = Activity.current.exampleActivityList
    
    var body: some View {
        ScrollContentView {
            
            // MARK: Steps Taken card
            InformationCard(image: "Boot", title: "Steps", text: "8000", secondaryText: "/ 12000")
                .background(defaultShape.fill(ApplicationLinearGradient.blueGradient).opacity(0.85))
            
            
            // MARK: Calories burned and gained
            HStack {
                InformationCard(image: "FireLogo", title: "Burned", text: "195 kCal")
                    .background(defaultShape.fill(ApplicationLinearGradient.orangeGradient).opacity(0.85))
                
                InformationCard(image: "Food", title: "Consumed", text: "1900 kCal")
                    .background(defaultShape.fill(ApplicationLinearGradient.greenGradient).opacity(0.85))
                
            }
            .frame(maxWidth: .infinity)
            
            
            // MARK: Agenda today section
            SecondaryHeading(title: "Agenda Today")
                .padding(.top, 25)
            
            // MARK: Agenda today card
            VStack(spacing: 0) {
                ForEach(self.AgendaToday.indices, id: \.self) { index in
                    CheckBoxWithText(text: self.AgendaToday[index].title, checked: self.$AgendaToday[index].isDone)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 15)
                    
                    
                    if index != self.AgendaToday.count - 1 {
                        CustomDivider()
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .background(.darkBG)
            .overlay {
                defaultShape
                    .stroke(.white.opacity(0.18))
            }
            .clipShape(defaultShape)
            
            
            // MARK: Recent Activities
            SecondaryHeading(title: "Recent Activities")
                .padding(.top, 25)
            
            HStack {
                // MARK: Activities button
                NavigationLink(destination: ActivityScreen()) {
                    PrimaryNavigationButton(text: "Activities")
                        .background(defaultShape.fill(ApplicationLinearGradient.redGradient))
                        .overlay {
                            HStack {
                                Circle()
                                    .fill(.white.opacity(0.25))
                                    .frame(width: 25, height: 25)
                                    .overlay {
                                        Text("3")
                                            .font(.custom(ApplicationFonts.oswaldRegular, size: 15))
                                            .foregroundStyle(.white)
                                    }
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 10)
                            .offset(y: 0)
                        }
                    
                }
                
                // MARK: Choose Workout Button
                NavigationLink(destination: ChooseWorkoutScreen()) {
                    PrimaryNavigationButton(text: "Workout")
                        .background(defaultShape.fill(ApplicationLinearGradient.thanosGradient))
                        .overlay {
                            HStack {
                                Image("Workout")
                                    .resizable()
                                    .frame(width: 30, height: 25)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 10)
                            .offset(y: 0)
                        }
                }
                
            }
            .frame(maxWidth: .infinity)
            
            VStack(spacing: 5) {
                ForEach(self.RescentActivities, id: \.id) { activity in
                    NavigationLink(destination: ActivityDetailsScreen(activity: activity)) {
                        ActivityViewCard(activity: activity)
                    }
                }
                
            }
           
        }
        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
    }
}






#Preview {
    HomeScreen()
}
