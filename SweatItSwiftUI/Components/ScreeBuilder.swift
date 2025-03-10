//
//  ScreeBuilder.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 09/03/25.
//

import SwiftUI

struct ScreenBuilder<Content: View>: View {
    
    var content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            self.content
        }
        .addAppLinearGradient()
        .navigationBarBackButtonHidden()
    }
}
