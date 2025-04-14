//
//  WorkoutPageComponents.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 21/01/25.
//

import SwiftUI


struct WorkoutPageSearchBar: View {
    var body: some View {
        HStack {
            Text("Search")
                .font(.custom("Poppins-Medium", size: 20))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 24)
        .frame(width: UIScreen.main.bounds.width * 0.9)
        .frame(height: 58)
        .background(Color.darkBG.opacity(0.54))
        .cornerRadius(17)
        .overlay {
            RoundedRectangle(cornerRadius: 17)
                .stroke(.white.opacity(0.18))
        }
        
        
        
    }
}


struct ExerciseOfTheDayCard: View {
    var isTop: Bool = false
    var title: String = "Dumbbell Lateral Raises"
    var tags: Array<String> = ["Traps", "Shoulders"]
    var url: String = "https://www.kettlebellkings.com/cdn/shop/articles/weighted-push-up_1200x1200_crop_center.gif?v=1701426793"
    var body: some View {
        HStack {
            HStack {
                AsyncImage(url: URL(string: url)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .tint(.white)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    case .failure(let error):
                        Text("Image here")
                            .font(.system(size: 10, weight: .semibold, design: .rounded))
                            .foregroundStyle(.white.opacity(0.5))
                    }
                }
            }
            .frame(maxWidth: 113, maxHeight: .infinity)
            .background(.white)
            
            VStack {
                Text(self.title)
                    .font(.system(size: 20, weight: .light, design: .rounded))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                HStack {
                    ForEach(self.tags, id: \.self) {item in
                        Text(item)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 7)
                            .font(.custom("RobotoCondensed-Light", size: 15))
                            .foregroundStyle(.white.opacity(0.4))
                            .background(.white.opacity(0.17))
                            .cornerRadius(100)
                        
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
        }
        .frame(maxWidth: UIScreen.main.bounds.width * 0.9)
        .frame(height: 100)
        .border(.white.opacity(0.18))
        .background(Color.darkBG)
        .clipShape(UnevenRoundedRectangle(cornerRadii: .init(topLeading: isTop ? 17 : 0, bottomLeading: !isTop ? 17 : 0, bottomTrailing: !isTop ? 17 : 0, topTrailing: isTop ? 17 : 0)))
    }
}

struct WorkoutCard: View {
    
    var image: String
    var name: String
    var difficulty: Extras.Difficulty
    var wantMargin: Bool = false
    var sideOffset: CGFloat
    var isViewCard: Bool = false
    var caloriesBurned: Int = 120
    var duration: String = "32 MINS"
    
    var body: some View {
        ZStack {
            
            // MARK: Content view
            VStack(spacing: 5) {
                Text(self.name)
                    .font(.custom(ApplicationFonts.oswaldRegular, size: 15))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(self.difficulty.rawValue)
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(.white.opacity(0.06))
                    .overlay {
                        Capsule()
                            .stroke(.white.opacity(0.18))
                    }
                    .clipShape(Capsule())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            
            
            // MARK: Arrow
            if !self.isViewCard {
                HStack {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.white.opacity(0.5))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                .padding(.horizontal, 20)
            }
            
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: self.isViewCard ? 60 : 80)
        .padding()
        .background(.darkBG.opacity(0.54))
        .overlay {
            defaultShape
                .stroke(.white.opacity(0.18))
        }
        .clipShape(defaultShape)
        .clipped()
        .overlay {
            
            // MARK: Image here
            HStack {
                Image(self.image)
                    .offset(x: self.sideOffset)
                    .opacity(self.isViewCard ? 0.5 :1)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay {
                if self.isViewCard {
                    HStack(spacing: 5) {
                        
                        // MARK: Calories burned
                        HStack(spacing: 5) {
                            Text("\(self.caloriesBurned)")
                                .font(.custom(ApplicationFonts.oswaldRegular, size: 20))
                                .foregroundStyle(.white)
                            
                            Text("🔥")
                                .font(.system(size: 20))
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 8)
                        .background(.darkBG.opacity(0.54))
                        .background(AppBackgroundBlur(radius: 100, opaque: true))
                        .overlay {
                            defaultShape
                                .stroke(.white.opacity(0.18))
                        }
                        .clipShape(defaultShape)
                        
                        // MARK: Time taken
                        HStack(spacing: 5) {
                            Text(self.duration.split(separator: " ").first!)
                                .font(.custom(ApplicationFonts.oswaldRegular, size: 20))
                                .foregroundStyle(.white)
                            
                            Text("🕘")
                                .font(.system(size: 18))
                                .offset(y: 1)
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 8)
                        .background(.darkBG.opacity(0.54))
                        .background(AppBackgroundBlur(radius: 100, opaque: true))
                        .overlay {
                            defaultShape
                                .stroke(.white.opacity(0.18))
                        }
                        .clipShape(defaultShape)
                        
                        Image(systemName: "chevron.right")
                            .scaleEffect(0.75)
                            .foregroundStyle(.white.opacity(0.75))
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                    .padding(.horizontal, 25)
                    
                }
            }
        }
        .clipShape(defaultShape)
    }
}



