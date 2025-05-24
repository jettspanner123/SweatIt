//
//  CheckboxWithText.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 09/03/25.
//

import SwiftUI
struct CheckBoxWithText: View {
    
    var text: String
    var checked: Bool
    var isTop: Bool = false
    var isBottom: Bool = false
    
    func getBackground() -> LinearGradient {
        if self.checked {
         return ApplicationLinearGradient.greenSameGradient
        }
        return ApplicationLinearGradient.clearGradient
    }
    
    var body: some View {
        HStack {
            Image(systemName: self.checked ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 20, height: 20)
            
            Text(self.text)
                .font(.system(size: 13.5, weight: .regular, design: .rounded))
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 15)
        .padding(15)
        .background(self.getBackground())
    }
}

