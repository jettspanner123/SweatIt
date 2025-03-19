//
//  CustomDynamicIsland.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 19/03/25.
//

import SwiftUI

struct CustomDynamicIsland: View {
    
    @Binding var showIsland: Bool
    var color: Color
    var body: some View {
        
        VStack {
            
            HStack {
                
            }
            .frame(width: self.showIsland ? 120 : 0, height: self.showIsland ? 30 : 0)
            .background(.appRedDark)
            .padding(.top, 1)
            .clipShape(Capsule())
            .position(x: UIScreen.main.bounds.width / 2, y: -30)
            .blur(radius: self.showIsland ? 10 : 0)
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.clear)
        .allowsHitTesting(false)
    }
}

