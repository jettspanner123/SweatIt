//
//  FullScreenView.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 10/04/25.
//

import SwiftUI

struct FullScreenView<Content: View>: View {
   
    var content: () -> Content
    var body: some View {
        VStack {
            self.content()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
