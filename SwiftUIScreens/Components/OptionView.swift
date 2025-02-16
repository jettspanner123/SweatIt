//
//  OptionView.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 27/01/25.
//

import SwiftUI

struct OptionView: View {
    
    @State var isSelected: Bool = false
    var title: String = "Chest Workout"
    
    var body: some View {
        HStack {
            Text(self.title)
                .font(.custom("Oswald-Regular", size: 20))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 28)
        .frame(maxWidth: UIScreen.main.bounds.width * 0.9)
        .frame(height: 76)
        .background(
            LinearGradient(gradient: Gradient(colors: [self.isSelected ? Color.appBlueLight : Color.darkBG.opacity(0.54), self.isSelected ? Color.appBlueDark : Color.darkBG.opacity(0.54)]), startPoint: .top, endPoint: .bottom)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 17)
                .stroke(.white.opacity(0.08))
        )
        .cornerRadius(17)
        .onTapGesture {
            withAnimation(.spring()) {
                self.isSelected.toggle()
            }
        }
    }
}

struct FloatingButtonBluredBackground: View {
    var text: String = "Next"
    var body: some View {
        HStack {
            Text(self.text)
                .font(.custom("Oswald-Regular", size: 30))
                .foregroundStyle(.white)
            
        }
        .frame(width: UIScreen.main.bounds.width * 0.9, height: 75)
        .background(AppBackgroundBlur(radius: 50, opaque: true))
        .background(.darkBG.opacity(0.54))
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(.white.opacity(0.08))
        )
        .cornerRadius(30)
    }
}

#Preview {
    FloatingButtonBluredBackground()
}
