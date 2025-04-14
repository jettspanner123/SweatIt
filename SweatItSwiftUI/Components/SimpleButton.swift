//
//  SimpleButton.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 10/04/25.
//

import SwiftUI

struct SimpleButton<Content: View>: View {
    
    
    var content: Content
    var backgroundGradient: LinearGradient = ApplicationLinearGradient.redGradient
    var roundness: Double = 17
    var action: () -> Void = {}
    
    @State var buttonClickCount: Int = 0

    init(@ViewBuilder content: () -> Content, backgroundLinearGradient: LinearGradient, some action: @escaping () -> Void, roundness: Double = 17) {
        self.content = content()
        self.backgroundGradient = backgroundLinearGradient
        self.action = action
        self.roundness = roundness
    }
    
    var body: some View {
        HStack {
            self.content
        }
        .frame(maxWidth: .infinity)
        .frame(height: 45)
        .overlay {
            RoundedRectangle(cornerRadius: self.roundness)
                .stroke(.white.opacity(0.18))
        }
        .background(self.backgroundGradient)
        .clipShape(RoundedRectangle(cornerRadius: self.roundness))
        .onTapGesture {
            self.buttonClickCount += 1
            self.action()
        }
        .sensoryFeedback(.impact, trigger: self.buttonClickCount)
    }
}
