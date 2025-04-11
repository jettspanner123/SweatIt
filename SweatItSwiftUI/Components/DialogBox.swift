//
//  DialogBox.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 11/04/25.
//

import SwiftUI

struct DialogBox<Content: View>: View {
    
    var content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack {
            
            VStack {
                self.content
            }
            .frame(maxWidth: .infinity)
            .frame(minHeight: 150, alignment: .topLeading)
            .padding(ApplicationPadding.mainScreenHorizontalPadding * 1.5)
            .padding(.bottom, 15)
            .background(.darkBG)
            .clipShape(UnevenRoundedRectangle(cornerRadii: .init(topLeading: 17, topTrailing: 17)))
            .ignoresSafeArea()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
        .ignoresSafeArea()
        .zIndex(ApplicationBounds.dialogBoxZIndex)
        .transition(.offset(y: UIScreen.main.bounds.height))
    }
}
