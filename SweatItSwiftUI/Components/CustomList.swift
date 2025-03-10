//
//  CustomList.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 11/03/25.
//

import SwiftUI

struct CustomList<Content: View>: View {
    
    var content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body: some View {
        VStack {
            self.content
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(.darkBG.opacity(0.54))
        .overlay {
            defaultShape
                .stroke(.white.opacity(0.18))
        }
        .clipShape(defaultShape)
    }
}
