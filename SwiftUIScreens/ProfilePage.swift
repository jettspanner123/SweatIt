//
//  SwiftUIView.swift
//  iOS PulseFit
//
//  Created by Soham Chakraborty on 13/01/25.
//

import SwiftUI

struct ProfileView: View {
//    @Binding var currentPage_t: Int
    var body: some View {
        ZStack {
            
            PageHeader(pageHeaderTitle: "Profile")
            
            ScrollView {
                VStack(spacing: 0) {
                    VStack(spacing: 0) {
                        HStack(spacing: 20) {
                            ZStack(alignment: .bottom) {
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(colors:[Color("AppBlueLight"), Color("AppBlueDark")]),
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )
                                    .frame(width: 131, height: 125)
                                
                                Image("bjuice")
                                    .resizable()
                                    .frame(width: 124, height: 110)
                                    .clipShape(Circle())
                            }
                            
                            
                            VStack(alignment: .leading) {
                                Text("Singh")
                                    .fontWeight(.bold)
                                
                                    .font(.custom("SF Compact Rounded", size: 22))
                                    .foregroundColor(.white)
                                
                                Text("Uddeshya")
                                    .font(.custom("SF Compact Rounded", size: 22))
                                    .fontWeight(.light)
                                    .foregroundColor(.white)
                                Spacer()
                                HStack {
                                    Text("382")
                                        .foregroundColor(.white)
                                        .fontWeight(.medium)
                                        .font(.system(size: 22))
                                    Text("🔥")
                                        .foregroundColor(.orange)
                                        .fontWeight(.medium)
                                }
                                .offset(y: -10)
                            }
                            .frame(maxHeight: .infinity, alignment: .top)
                            
                            Spacer()
                            
                            Button(action: {
                            }) {
                                Image(systemName: "person.fill.badge.plus")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding(6)
                                
                            }
                            .background(Color(.white).opacity(0.07)
                            )
                            .cornerRadius(10)
                            .offset(x: -10, y: 30)
                            
                        }
                        .padding()
                        
                    }
                    .padding(.top, 80)
                    
                    
                    HStack(spacing: -20) {
                        HStack(spacing: -11) {
                                Text("17")
                                    .font(.custom("Oswald-SemiBold", size: 80))
                                    .bold()
                                    .foregroundColor(.black)
                                    .offset(x:-14)
                                VStack (alignment: .leading, spacing: -10){
                                    Text("Health")
                                        .font(.custom("Poppins-Light", size: 20))
                                        .offset(x:4, y:14)
                                    
                                    Text("Level")
                                        .font(.custom("Poppins-Bold", size: 30))
                                        .offset(x:4, y:10)
                                }
                        }
                        .frame(height: 120)
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(gradient: Gradient(colors:[Color.white, Color.gray]), startPoint: .top, endPoint: .bottom))
                        .cornerRadius(16)
                        .padding(.bottom)
                        
                        VStack {
                            HStack {
                                Text("62")
                                    .font(.custom("Oswald", size: 80))
                                    .bold()
                                    .foregroundColor(.white)
                                Image("Friends")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .offset(y: 12)
                                    .foregroundColor(.white)
                            }
                            
                            
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 120)
                        .background(LinearGradient(gradient: Gradient(colors: [Color("AppBlueLight"), Color("AppBlueDark")]), startPoint: .top, endPoint: .bottom))
                        .cornerRadius(16)
                        .padding(.bottom)
                    }
                    .padding(.horizontal)
                    
                    
                    VStack(spacing: 0) {
                        MenuItem(icon: "person.fill", title: "User Details")
                        Divider().background(Color.white)
                        MenuItem(icon: "bell.fill", title: "Notifications")
                        Divider().background(Color.white)
                        MenuItem(icon: "hand.thumbsup.fill", title: "Recommendations")
                    }
                    .background(Color("PageHeadingColor").opacity(0.54)
                    )
                    .shadow(color: .black.opacity(0.6), radius: 4, x: 0, y: 2)
                    .overlay(
                        RoundedRectangle(cornerRadius: 17)
                            .stroke(Color.gray, lineWidth: 0.8)
                    )
                    .padding(.horizontal)
                    
                    
                    HeadingWithLink(titleHeading: "Past Stats", extraHeading: "", showExtraHeading: false)
                        .offset(y: 10)
                    AvgStepCountGraph()
                    
                    HeadingWithLink(titleHeading: "Top Performers", extraHeading: "", showExtraHeading: false)
                        .offset(y: 10)
                    
                    TopLeaderboardPerformers(firstPerson: ("jettspanner123", 1000), secondPerson: ("ronny_irani123", 2000), thirdPerson: ("runy_gamer", 3000))

                    

                    
                    
                    Spacer()
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [Color("DarkBG"), Color.black]), startPoint: .top, endPoint: UnitPoint(x: 0.5, y: 1.6)).ignoresSafeArea())
            
//            PageNavigationBar(currentPage_t: $currentPage_t, currentPage: "Profile")
        }
    }
    
    
}

struct MenuItem: View {
    var icon: String
    var title: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white)
            Text(title)
                .foregroundColor(.white)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct TopLeaderboardPerformers: View {
    var firstPerson: (String, Int)
    var secondPerson: (String, Int)
    var thirdPerson: (String, Int)
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    
                }
                .frame(width: 100, height: 100)
                .background(.white)
                .cornerRadius(17)
                
                Text(firstPerson.0)
                    .font(.custom("Poppins-Light", size: 13))
                    .foregroundStyle(.white)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 210)
        .background(.white.opacity(0.08))
        .padding(.horizontal, 23)
        .cornerRadius(16)
    }
}


struct AvgStepCountGraph: View {
    var body: some View {
        VStack {
            
            VStack {
                HStack(alignment: .bottom) {
                    Text("Avg Step Count")
                    .font(.custom("RobotoCondensed-Medium", size: 30))
                    .foregroundStyle(.white)
                    
                    Text("( this month )")
                        .font(.custom("RobotoCondensed-Medium", size: 15))
                        .foregroundStyle(.white.opacity(0.35))
                        .offset(y: -5)

                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(alignment: .bottom) {
                    Text("13,456")
                        .font(.custom("Oswald-Medium", size: 50))
                        .foregroundStyle(.white.opacity(0.7))
                    
                    Text("steps")
                        .font(.custom("RobotoCondensed-Light", size: 30))
                        .foregroundStyle(.white.opacity(0.41))
                        .offset(y: -10)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Image("AvgStepCountGraph")
                    .resizable()
                    .frame(maxWidth: 344.5, maxHeight: 152)
                    .offset(y: -15)

            }
            .padding(25)
            .frame(width: UIScreen.main.bounds.width * 0.9)
            .frame(height: 358)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color("AppBlueDark"), Color("AppBlueLight")]), startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x: 0.5, y: 1))
            )
            .cornerRadius(17)
            
            
            
        }
    }
}

#Preview {
    ProfileView()
}
