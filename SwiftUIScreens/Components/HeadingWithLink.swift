//
//  HeadingWithLink.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 20/01/25.
//

import SwiftUI

struct HeadingWithLink: View {
    var titleHeading: String
    var extraHeading: String
    @State var showExtraHeading: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                Text(titleHeading)
                    .font(.system(size: 35, weight: .light, design: .rounded))
                    .foregroundStyle(.white)
                
                Text(extraHeading)
                    .font(.system(size: 20, weight: .light, design: .rounded))
                    .foregroundStyle(Color("AppGreyLight").opacity(0.85))
                    .kerning(-1)
            }
            
            Spacer()
            
            HStack {
                Text("See All >")
                    .font(.system(size: 15, weight: .light, design: .rounded))
                    .foregroundStyle(Color("AppGreyLight").opacity(1))
                    .offset(y: -10)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 28)
        .padding(.top, 40)
        .padding(.bottom, 16)
    }
}

