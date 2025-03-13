//
//  FoodDetailScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 14/03/25.
//

import SwiftUI

struct FoodDetailScreen: View {
    var food: Food_t
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ScrollView(showsIndicators: false) {
           
            GeometryReader { proxy in
                Image(self.food.foodImage)
                    .resizable()
            }
            .frame(height: 300)
            .background(.blue.gradient)
            
            VStack {
                Text(self.food.foodName)
                    .font(.custom(ApplicationFonts.oswaldRegular, size: 30))
                    .takeMaxWidthLeading()
                
                ForEach(1...5, id: \.self) { _ in
                    HStack {
                        
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                    .background(.green)
                }
            }
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            .navigationBarBackButtonHidden()
        }
    }
}

//#Preview {
//    FoodDetailScreen()
//}
