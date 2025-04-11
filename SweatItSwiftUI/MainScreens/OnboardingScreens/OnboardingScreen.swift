//
//  OnboardingScreen.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 10/04/25.
//

import SwiftUI

struct OnboardingScreen: View {
    
    enum OnboardingPages: String, CaseIterable {
        case first, second, thrid
    }
    
    @State var currentSelectedPage: OnboardingPages = .first
    
    
    var body: some View {
        VStack {
            switch self.currentSelectedPage {
            case .first:
                self.firstPage
            case .second:
                self.secondPage
            case .thrid:
                self.thirdPage
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    
    var firstPage: some View {
        FullScreenView {
            ZStack {
                
            }
        }
    }
    
    var secondPage: some View {
        FullScreenView {
            ZStack {
                
            }
        }
    }
    
    var thirdPage: some View {
        FullScreenView {
            ZStack {
                
            }
        }
    }
}

#Preview {
    OnboardingScreen()
}
