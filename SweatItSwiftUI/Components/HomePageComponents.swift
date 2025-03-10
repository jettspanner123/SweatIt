//
//  HomePageComponents.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 19/01/25.
//

import SwiftUI


struct HomePageStepCounter: View {
    
    @State var currentStepCount: Int
    @State var goalStepCount: Int
    
    var body: some View {
        VStack {
            HStack(spacing: 11) {
                
                HStack {
                    Image("Boot")
                }
                .frame(width: 30, height: 30)
                .background(.white.opacity(0.17))
                .cornerRadius(100)
                
                Text("Steps")
                    .foregroundStyle(.white)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
            }
            .offset(x: -120, y: 8)
            
            HStack(spacing: 8) {
                Text("\(currentStepCount)")
                    .font(.custom("Oswald-Regular", size: 40))
                    .foregroundStyle(.white.opacity(0.7))
                Text("/")
                    .font(.custom("Oswald-Regular", size: 40))
                    .foregroundStyle(.white.opacity(0.7))
                Text("\(goalStepCount)")
                    .font(.custom("Oswald-Regular", size: 30))
                    .foregroundStyle(.white.opacity(0.7))
                    .offset(y: 2)
            }
            .offset(x: -65, y: -10)
        }
        .frame(maxWidth: UIScreen.main.bounds.width*0.9)
        .frame(height: 115)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("AppBlueLight"), Color("AppBlueDark")]), startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x: 0.5, y: 1))
        )
        .cornerRadius(17)
    }
}


struct HomePageCalories: View {
    @State var caloriesConsumed: Int
    @State var caloriesBurned: Int
    @State var totalCalories: Int
    
    var body: some View {
        HStack(spacing: 15) {
            
            
            // Calories Burned Card
            ZStack {
                HStack(spacing: 11) {
                    
                    HStack {
                        Image("FireLogo")
                    }
                    .frame(width: 30, height: 30)
                    .background(.white.opacity(0.17))
                    .cornerRadius(100)
                    
                    Text("Burned")
                        .foregroundStyle(.white)
                        .font(.system(size: 18, weight: .regular, design: .rounded))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .offset(y: -30)
                
                
                Text("\(caloriesBurned) kCal")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .foregroundStyle(.white.opacity(0.75))
                    .font(.custom("Oswald-Regular", size: 30))
                    .offset(y: 15)
                    .zIndex(100)
                
                
                Text("🔥")
                    .font(.system(size: 100))
                    .opacity(0.28)
                    .offset(x: 80, y:5)
            }
            .frame(maxWidth: (UIScreen.main.bounds.width / 2) - 30, maxHeight: 115)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color("AppOrangeLight"), Color("AppOrangeDark")]), startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x: 0.5, y: 1))
            )
            .cornerRadius(17)
            
            
            
            // Calories Consumed card
            ZStack {
                HStack(spacing: 11) {
                    
                    HStack {
                        Image("Food")
                    }
                    .frame(width: 30, height: 30)
                    .background(.white.opacity(0.17))
                    .cornerRadius(100)
                    
                    Text("Consumed")
                        .foregroundStyle(.white)
                        .font(.system(size: 18, weight: .regular, design: .rounded))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .offset(y: -30)
                
                
                HStack {
                    Text("\(caloriesConsumed)")
                        .foregroundStyle(.white.opacity(0.75))
                        .font(.custom("Oswald-Regular", size: 25))
                    
                    Text("/")
                        .foregroundStyle(.white.opacity(0.75))
                        .font(.custom("Oswald-Regular", size: 30))
                    
                    Text("\(totalCalories)")
                        .foregroundStyle(.white.opacity(0.75))
                        .font(.custom("Oswald-Regular", size: 20))
                        .offset(y: 0)
                        .zIndex(100)
                }
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .offset(y: 15)
                
                
                
                
                Text("🥦")
                    .font(.system(size: 100))
                    .scaleEffect(x: -1, y: 1, anchor: .center)
                    .opacity(0.28)
                    .offset(x: 80, y:20)
                
            }
            .frame(maxWidth: (UIScreen.main.bounds.width / 2) - 30, maxHeight: 115)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color("AppGreenLight"), Color("AppGreenDark")]), startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x: 0.5, y: 1))
            )
            .cornerRadius(17)
            
            
        }
    }
}



struct AgendaTodayList: View {
    
    @State var todayAgenda: Array<(String, Bool)> = [
        ("Chest Workout", false),
        ("Tricep Workout", false),
        ("15,000 Steps", false),
        ("2.1L Water", false),
        ("2500 kCal Intake", false),
        ("250 kCal Burn", false),
        ("Complete a challenge", false),
    ]
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<todayAgenda.count) { index in
                HStack {
                    Image(self.todayAgenda[index].1 ? "Checkbox" : "UCheckbox")
                        .resizable()
                        .frame(width: 30, height: 30)
                    
                    Text("\(self.todayAgenda[index].0)")
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: UIScreen.main.bounds.width * 0.8, alignment: .leading)
                .onTapGesture {
                    self.todayAgenda[index].1.toggle()
                }
                
                .padding()
                .background(Color("DarkBG").opacity(0.54))
                .overlay {
                    Rectangle()
                        .frame(height: index != 6 ? 1 : 0)
                        .foregroundStyle(.white.opacity(0.18))
                        .offset(y: 30)
                }
                
                .clipShape(
                    .rect(
                        topLeadingRadius: index == 0 ? 20 : 0,
                        bottomLeadingRadius: index == 7 ? 20 : 0,
                        bottomTrailingRadius: index == 7 ? 20 : 0,
                        topTrailingRadius: index == 0 ? 20 : 0
                    )
                )
            }
        }
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white.opacity(0.18))
        }
    }
}

struct HomePageHydrationCounter: View {
    
    @State var hydrationCount: Int = 500
    @State var increaseCount: Int = 250
    
    var body: some View {
        ZStack {
            HStack(spacing: 11) {
                
                HStack {
                    Image("Water")
                }
                .frame(width: 30, height: 30)
                .background(.white.opacity(0.17))
                .cornerRadius(100)
                
                Text("Hydration")
                    .foregroundStyle(.white)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
            }
            .offset(x: -100, y: -25)
            
            Text("\(hydrationCount) mL")
                .font(.custom("Oswald-Regular", size: 35))
                .foregroundStyle(.white.opacity(0.72))
                .offset(x: String(hydrationCount).count == 4 ? String(hydrationCount).count == 1 ? -150 : -95 : -110, y: 15)
            
            HStack {
                HStack {
                    Image("Minus")
                }
                .frame(maxWidth: 80, maxHeight: 80)
                .background(Color("AppWaterDark").opacity(0.8))
                .border(.white.opacity(0.08), width: 1)
                .cornerRadius(20)
                .onTapGesture {
                    if self.hydrationCount > 0 {
                        self.hydrationCount -= self.increaseCount
                    }
                }
                
                HStack {
                    Image("Plus")
                }
                .frame(maxWidth: 80, maxHeight: 80)
                .background(Color("AppWaterDark").opacity(0.8))
                .border(.white.opacity(0.08), width: 1)
                .cornerRadius(20)
                .onTapGesture {
                    self.hydrationCount += self.increaseCount
                }
                
            }
            .offset(x: 85)
            
            
            
        }
        .frame(maxWidth: UIScreen.main.bounds.width * 0.9)
        .frame(height: 115)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("AppWaterDark"), Color("AppWaterLight")]), startPoint: UnitPoint(x: 0, y: 0.5), endPoint: UnitPoint(x: 1, y: 0.5))
        )
        .cornerRadius(20)
    }
}

struct RecentActivitiesTwinButton: View {
    var body: some View {
        HStack {
            HStack {
                HStack(spacing: 5) {
                    HStack {
                        Text("3")
                            .font(.custom("Oswald-Regular", size: 20))
                    }
                    .frame(width: 30, height: 30)
                    .background(.white.opacity(0.57))
                    .cornerRadius(100)
                    
                    Text("Activities")
                        .font(.custom("Oswald-Regular", size: 20))
                        .foregroundStyle(.white.opacity(0.61))
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .offset(x: 15)
                
                HStack {
                    Image("Back")
                }
                .frame(width: 30, height: 30)
                .background(.black.opacity(0.17))
                .cornerRadius(100)
                .offset(x: -15)
            }
            .frame(maxWidth: (UIScreen.main.bounds.width / 2) - 25)
            .frame(height: 77)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color("AppRedLight"), Color("AppRedDark")]), startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x: 0.5, y: 1))
            )
            .cornerRadius(17)
            
            HStack {
                
                HStack(spacing: 5){
                    Image("Workout")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .opacity(0.69)
                    
                    Text("Workout")
                        .font(.custom("Oswald-Regular", size: 20))
                        .foregroundStyle(.white.opacity(0.61))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .offset(x: 15)
                
                HStack {
                    Image("Back")
                }
                .frame(width: 30, height: 30)
                .background(.black.opacity(0.17))
                .cornerRadius(100)
                .offset(x: -15)
            }
            .frame(maxWidth: (UIScreen.main.bounds.width / 2) - 25)
            .frame(height: 77)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color("AppThanosLight"), Color("AppThanosDark")]), startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x: 0.5, y: 1))
            )
            .cornerRadius(17)
            
        }
    }
}


struct ActivityCard: View {
    
    var isTop: Bool = true
    var isBottom: Bool = false
    var heading: String = "Chest Workout"
    var secondaryHeading: String = "Chest, Triceps"
    var tertiaryHeading: String = "🔥 320 kCal"
    var image: String
    
    var body: some View {
        HStack {
            HStack {
                Image(self.image)
                    .resizable()
                
            }
            .frame(width: 149, height: 149)
            
            VStack(alignment: .leading) {
                Text(self.heading)
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(self.secondaryHeading)
                    .font(.system(size: 15, weight: .light, design: .rounded))
                    .foregroundStyle(.white.opacity(0.5))
                    .padding(.horizontal, 2)
                
                Spacer()

                Text(self.tertiaryHeading)
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                    .foregroundStyle(.white)
                

            }
            .padding(.horizontal, 10)
            .padding(.vertical, 15)
            .padding(.bottom, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(width: UIScreen.main.bounds.width * 0.9, height: 150)
        .background(.darkBG.opacity(0.54))
        .clipShape(
            UnevenRoundedRectangle(cornerRadii: .init(topLeading: isTop ? 17 : 0, bottomLeading: isBottom ? 17 : 0, bottomTrailing: isBottom ? 17 : 0, topTrailing: isTop ? 17 : 0))
        )
        .overlay(
            UnevenRoundedRectangle(cornerRadii: .init(topLeading: isTop ? 17 : 0, bottomLeading: isBottom ? 17 : 0, bottomTrailing: isBottom ? 17 : 0, topTrailing: isTop ? 17 : 0))
                .stroke(.white.opacity(0.08))
        )
    }
}


#Preview {
}
