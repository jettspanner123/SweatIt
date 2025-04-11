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
    var action: () -> Void = {}
    
    @State var buttonClickCount: Int = 0

    init(@ViewBuilder content: () -> Content, backgroundLinearGradient: LinearGradient, some action: @escaping () -> Void) {
        self.content = content()
        self.backgroundGradient = backgroundLinearGradient
        self.action = action
    }
    
    var body: some View {
        HStack {
            self.content
        }
        .frame(maxWidth: .infinity)
        .frame(height: 45)
        .background(self.backgroundGradient)
        .clipShape(defaultShape)
        .onTapGesture {
            self.buttonClickCount += 1
            self.action()
        }
        .sensoryFeedback(.impact, trigger: self.buttonClickCount)
    }
}
