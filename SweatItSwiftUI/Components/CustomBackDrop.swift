//
//  CustomBackDrop.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 11/04/25.
//

import SwiftUI

struct CustomBackDrop: View {
    var body: some View {
        VStack {
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppBackgroundBlur(radius: 5, opaque: true))
        .background(.black.opacity(0.75))
        .zIndex(ApplicationBounds.backdropZIndex)
    }
}

#Preview {
    CustomBackDrop()
}
