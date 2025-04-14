//
//  CustomTextField.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 12/04/25.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var searchText: String
    var placeholder: String
    
    var body: some View {
        TextField("", text: self.$searchText, prompt: Text(self.placeholder).font(.system(size: 13)).foregroundStyle(.white.opacity(0.5)))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .padding(.horizontal)
            .background(.darkBG.opacity(0.54))
            .overlay {
                defaultShape
                    .stroke(.white.opacity(0.18))
            }
            .clipShape(defaultShape)
            .allowsHitTesting(true)
        
    }
}

