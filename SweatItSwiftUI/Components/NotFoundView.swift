//
//  NotFoundView.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 04/06/25.
//

import SwiftUI

struct NotFoundView: View {
    
    var text: String
    var image: String = "tray.fill"
    var height: CGFloat = 50
    var width: CGFloat = 65
    
    var body: some View {
        VStack {
            Image(systemName: self.image)
                .resizable()
                .frame(width: self.width, height: self.height)
                .foregroundStyle(.white.opacity(0.5))
                .padding(.top, 25)
            
            Text(self.text)
                .font(.system(size: 15, weight: .regular, design: .rounded))
                .foregroundStyle(.white.opacity(0.5))
        }
    }
}

