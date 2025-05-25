//
//  PastStatisticsScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 14/03/25.
//

import SwiftUI

let ONE_DAY: Int = 86400

struct PastStatisticsScreen: View {
    
    @EnvironmentObject var appStates: ApplicationStates
    
    var datesToShow: Array<Date> = (0...6).reversed().map { Date().addingTimeInterval(TimeInterval(ONE_DAY * -$0))}
    @State var weeklyEvents: Array<DailyEvents_t> = DailyEvents.current.weeklyEvents
   
    @State var currentSelectedDate: String = ApplicationHelper.formatDateToHumanReadableWithoutTime(date: .now)
    @State var showAllFoodAndMeals: Bool = false
    @State var currentSelectedFoodItem: Optional<Food_t> = nil
    @State var showFoodDetails: Bool = false
    
    var currentSelectedDayData: DailyEvents_t? {
        for day in self.appStates.weeklyDailyEvents where ApplicationHelper.formatDateToHumanReadableWithoutTime(date: day.key) == self.currentSelectedDate {
            return day.value
        }
        return nil
    }
    
    
    var body: some View {
        ScreenBuilder {
            
            if self.showFoodDetails {
                FoodDetailScreen(food: self.currentSelectedFoodItem!, showFoodDetailsScreen: self.$showFoodDetails)
                    .zIndex(ApplicationBounds.dialogBoxZIndex)
                    .transition(.offset(y: UIScreen.main.bounds.height))
            }
            
            if self.showFoodDetails {
                CustomBackDrop()
                    .onTapGesture {
                        withAnimation {
                            self.showFoodDetails = false
                            self.currentSelectedFoodItem = nil
                        }
                    }
            }
            
            AccentPageHeader(pageHeaderTitle: self.currentSelectedDate)
                .contentTransition(.numericText(value: Double(self.currentSelectedDate.count)))
            
            ScrollContentView {
                
                
                ScrollViewReader { scrollProxy in
                    
                    
                    // MARK: THis is the horizontal scrol date picker
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            
                            Divider()
                                .frame(width: 10)
                                .frame(maxHeight: .infinity)
                            
                            ForEach(self.appStates.weeklyDailyEvents.sorted(by: { $0.key > $1.key }), id: \.value) { key, value in
                                DateShowCard(date: key, currentSelectedDate: self.$currentSelectedDate)
                            }
                            
                            Divider()
                                .frame(width: 10)
                                .frame(maxHeight: .infinity)
                                .id("lastObservableObject")
                                .tag("lastObservableObject")
                            
                        }
                    }
                    .onAppear {
                        withAnimation(.spring(duration: 1)) {
                            scrollProxy.scrollTo("lastObservableObject", anchor: .trailing)
                        }
                    }
                }
                
                
                
                // MARK: Activities on that day
                SecondaryHeading(title: "Activities")
                    .padding(.top, 25)
                    .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                
                
                if let currentSelectedDayData {
                    
                    
                    // MARK: Calores burned and ingested
                    HStack {
                       
                        InformationCard(image: "FireLogo", title: "Burned", text: String(format: "%.f kCal", currentSelectedDayData.caloriesBurnedForTheDay), secondaryText: "", textColor: .white, wantInformationView: false, content: {
                            
                        })
                        .background(defaultShape.fill(ApplicationLinearGradient.orangeGradient).opacity(0.85))
                        .contentTransition(.numericText(value: Double(currentSelectedDayData.caloriesBurnedForTheDay)))

                        
                        InformationCard(image: "Food", title: "Consumed", text: String(format: "%.f kCal", currentSelectedDayData.caloriesIngestedForTheDay), secondaryText: "", textColor: .white, wantInformationView: false, content: {})
                            .background(defaultShape.fill(ApplicationLinearGradient.greenGradient).opacity(0.85))
                            .contentTransition(.numericText(value: Double(currentSelectedDayData.caloriesIngestedForTheDay)))

                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                    
                    
                    
                    
                    // MARK: Steps taken
                    InformationCard(image: "Boot", title: "Steps Taken", text: "\(currentSelectedDayData.stepsTaken) / \(self.appStates.dailyNeeds.dailySteps)", secondaryText: "", textColor: .white, wantInformationView: false, content: {})
                        .background(defaultShape.fill(ApplicationLinearGradient.blueGradient))
                        .contentTransition(.numericText(value: Double(currentSelectedDayData.stepsTaken)))
                        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                    
                    
                    Button("Click Me ") {
                        print(self.appStates.weeklyDailyEvents.keys)
                    }
                    
                    // MARK: Food and meals
                    if currentSelectedDayData.mealsHad.count > 3 {
                        SecondaryHeading(title: "Food & Meals")
                    } else {
                        HeadingWithLink(titleHeading: "Food & Meals", action: {
                            self.showAllFoodAndMeals = true
                        })
                        .padding(.top, 25)
                        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                    }
                    
                    ForEach(currentSelectedDayData.mealsHad.prefix(3), id: \.id) { meal in
                        ForEach(meal.foodItems.prefix(1), id: \.id) { food in
                            FoodViewCard(food: food)
                                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                                .onTapWithScale {
                                    self.currentSelectedFoodItem = food
                                    withAnimation {
                                        self.showFoodDetails = true
                                    }
                                }
                        }
                    }
                    
                    
                    
                    // MARK: Exercises and Workout
                    SecondaryHeading(title: "Workout Performed")
                        .padding(.top, 25)
                        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                    
                   
                    if currentSelectedDayData.workoutsDone.isEmpty {
                        VStack(spacing: 0) {
                            
                            Image("Workout")
                                .resizable()
                                .frame(width: 70, height: 60)
                                .opacity(0.5)
                                .padding(.top, 25)
                            
                            Text("No Workout Performed 😔")
                                .font(.system(size: 15, weight: .regular, design: .rounded))
                                .foregroundStyle(.white.opacity(0.5))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 35)
                        .overlay {
                            defaultShape
                                .stroke(.white.opacity(0.18))
                        }
                        .background(.darkBG.opacity(0.54), in: defaultShape)
                        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                        
                    }
                    
                    ForEach(currentSelectedDayData.workoutsDone, id: \.id) { workout in
                        NavigationLink(destination: WorkoutDetailsPage(workout: workout)) {
                            WorkoutCard(image: workout.workoutImage, name: workout.workoutName, difficulty: workout.workoutDifficulty, sideOffset: 50)
                        }
                        .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                    }
                
                }
            }
        }
        .navigationDestination(isPresented: self.$showAllFoodAndMeals, destination: {
            ShowAllFoodAndMealsScreen(date: self.$currentSelectedDate)
        })
    }
}



struct DateShowCard: View {
    
    var date: Date
    @Binding var currentSelectedDate: String
    var body: some View {
        VStack {
            Text(ApplicationHelper.getDay(from: date).prefix(1))
                .font(.custom(ApplicationFonts.oswaldRegular, size: 20))
                .foregroundStyle(self.currentSelectedDate == ApplicationHelper.formatDateToHumanReadableWithoutTime(date: date) ? .black : .white.opacity(0.5))
                .frame(maxWidth: .infinity)
            
            Spacer()
            
            Text(String(ApplicationHelper.getDate(from: date)))
                .font(.system(size: 20, weight: .light, design: .rounded))
                .foregroundStyle(self.currentSelectedDate == ApplicationHelper.formatDateToHumanReadableWithoutTime(date: date) ? .black : .white.opacity(0.5))
                .frame(maxWidth: .infinity)
            
            Spacer()
            
        }
        .frame(width: 60, height: 70, alignment: .topLeading)
        .padding(.vertical, 8)
        .background(self.currentSelectedDate == ApplicationHelper.formatDateToHumanReadableWithoutTime(date: date) ? ApplicationLinearGradient.whiteGradientInverted : ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf)
        .overlay {
            defaultShape
                .stroke(.white.opacity(0.18))
        }
        .clipShape(defaultShape)
        .onTapGesture {
            withAnimation {
                self.currentSelectedDate = ApplicationHelper.formatDateToHumanReadableWithoutTime(date: date)
            }
        }
    }
}

#Preview {
    PastStatisticsScreen()
}
