//
//  DarkBackdrop.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 16/03/25.
//

import SwiftUI

struct DarkBackdrop<Content: View>: View {
    
    var content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack {
            self.content
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black.opacity(0.75))
    }
}

