//
//  Text_t.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 29/01/25.
//

import SwiftUI

struct Text_t: View {
    var text: String
    var body: some View {
        Text(self.text)
            .font(.custom("RobotoCondensed-Regular", size: 25))
            .frame(maxWidth: UIScreen.main.bounds.width * 0.85, alignment: .leading)
            .foregroundStyle(.white)
    }
}

