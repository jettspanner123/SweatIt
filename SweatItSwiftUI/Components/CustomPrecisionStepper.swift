//
//  CustomPrecisionStepper.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 12/04/25.
//

import SwiftUI

struct CustomPrecisionStepper<TypeOfValue: Numeric>: View {
    @Binding var value: TypeOfValue
    var body: some View {
        // MARK: Precision stepper for weight
        HStack {
            HStack {
                Image(systemName: "minus")
                    .foregroundStyle(.white.opacity(0.5))
                    .frame(maxWidth: .infinity)
            }
            .applicationDropDownButton()
            .onTapGesture {
                withAnimation {
                    self.value -= 1
                }
            }
            
            HStack {
                Image(systemName: "plus")
                    .foregroundStyle(.white.opacity(0.5))
                    .frame(maxWidth: .infinity)
            }
            .applicationDropDownButton()
            .onTapGesture {
                withAnimation {
                    self.value += 1
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

