//
//  Extensions.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 09/03/25.
//

import SwiftUI

extension View {
    func addAppLinearGradient() -> some View {
        self
            .background(ApplicationLinearGradient.applicationGradient)
    }
}
