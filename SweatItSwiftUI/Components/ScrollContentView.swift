//
//  ScrollContentView.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 09/03/25.
//

import SwiftUI

struct ScrollContentView<Content: View>: View {
    
    var content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 10) {
                self.content
            }
            .frame(maxWidth: .infinity)
            .padding(.top, ApplicationPadding.mainScreenVerticalPadding)
            .padding(.bottom, ApplicationPadding.mainScreenVerticalPadding + 20)
        }
    }
}
