//
//  CustomDropdown.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 12/04/25.
//

import SwiftUI

struct CustomDropdown<Content: View>: View {
    var showValue: String
    
    @State var isDropDownOpen: Bool = false
    var imageName: String = ""
    
    var content: Content
    
    init(imageName: String, showValue: String, @ViewBuilder content: () -> Content) {
        self.imageName = imageName
        self.showValue = showValue
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Image(systemName: self.imageName)
                    .foregroundStyle(.white.opacity(0.5))
                    .frame(width: 20)
                
                Text(self.showValue)
                    .font(.system(size: 15, weight: .regular, design: .rounded))
                    .foregroundStyle(.white.opacity(0.5))
                
                Spacer()
                
                Image(systemName: "chevron.down")
                    .foregroundStyle(.white.opacity(0.5))
                    .scaleEffect(0.75)
                    .rotationEffect(.degrees(self.isDropDownOpen ? 180 : 0))
            }
            .padding(.vertical, self.isDropDownOpen ? 15 : 0)
            
            
            
            // MARK: Gender options
            if self.isDropDownOpen {
                self.content
            }
        }
        .applicationDropDownButton()
        .clipped()
        .onTapGesture {
            withAnimation {
                self.isDropDownOpen.toggle()
            }
        }
        .onChange(of: self.showValue) {
            withAnimation {
                self.isDropDownOpen = false
            }
        }
    }
}

