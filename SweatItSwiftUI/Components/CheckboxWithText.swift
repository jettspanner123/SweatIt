//
//  CheckboxWithText.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 09/03/25.
//

import SwiftUI
struct CheckBoxWithText: View {
    
    var text: String
    @Binding var checked: Bool
    
    var body: some View {
        HStack {
            Image(self.checked ? "Checkbox" : "UCheckbox")
                .resizable()
                .frame(width: 20, height: 20)
            
            Text(self.text)
                .font(.system(size: 13.5, weight: .regular, design: .rounded))
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 15)
        .background(.white.opacity(0.001))
        .onTapGesture {
            ApplicationHelper.impactOccured(style: .heavy)
        }
    }
}

