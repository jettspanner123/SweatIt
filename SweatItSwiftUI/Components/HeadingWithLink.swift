//
//  HeadingWithLink.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 20/01/25.
//

import SwiftUI

struct HeadingWithLink: View {
    var titleHeading: String
    var extraHeading: String = ""
    
    var action: () -> Void = {}
    
    
    var body: some View {
        HStack {
            Text(self.titleHeading)
                .font(.system(size: 23, weight: .light, design: .rounded))
                .foregroundStyle(.white)
            
            Spacer()
            
            
            HStack {
                
                Text("See All")
                    .font(.system(size: 15, weight: .light, design: .rounded))
                    .foregroundStyle(.white)
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.white)
                    .scaleEffect(0.75)
            }
            .opacity(0.75)
            .padding(.vertical, 10)
            .background(.darkBG.opacity(0.001))
            .offset(y: 5)
            .onTapGesture {
                self.action()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 10)
    }
}

