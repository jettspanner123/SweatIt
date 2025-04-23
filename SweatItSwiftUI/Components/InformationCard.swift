//
//  InformationCard.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 09/03/25.
//

import SwiftUI
import TipKit

struct InformationCard: View {
    
    var image: String = ""
    var title: String = ""
    var text: String = ""
    var secondaryText: String = ""
    var textColor: Color = .white.opacity(0.75)
    var wantInformationView: Bool = true
    var value: Double = .zero
    var content: () -> Void = {}
    
    init(image: String, title: String, text: String, secondaryText: String, textColor: Color, wantInformationView: Bool, value: Double = .zero ,content: @escaping () -> Void ) {
        self.image = image
        self.title = title
        self.text = text
        self.secondaryText = secondaryText
        self.textColor = textColor
        self.wantInformationView = wantInformationView
        self.value = value
        self.content = content
    }
    
    
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: Icon and title
            HStack {
                Image(self.image)
                    .padding(5)
                    .overlay {
                        Circle()
                            .fill(.white.opacity(0.2))
                    }
                
                Text(self.title)
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(alignment: .bottom) {
                Text(self.text)
                    .font(.custom(ApplicationFonts.oswaldRegular, size: 25))
                    .foregroundStyle(self.textColor)
                    .padding(.leading, 5)
                    .contentTransition(.numericText(value: self.value))
                    .animation(.snappy, value: self.value)
                
                if !self.secondaryText.isEmpty {
                    Text(self.secondaryText)
                        .font(.custom(ApplicationFonts.oswaldRegular, size: 20))
                        .foregroundStyle(.white.opacity(0.75))
                        .offset(y: -5)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 65, alignment: .topLeading)
        .padding(10)
        .coordinateSpace(name: "InformationCardCoordinateSpace")
        .overlay(alignment: .topTrailing) {
            Image(systemName: "info.circle")
                .foregroundStyle(.white.opacity(0.5))
                .padding()
                .onTapWithScale {
//                    print("Hello world")
                    self.content()
                }
        }
        
    }
}

