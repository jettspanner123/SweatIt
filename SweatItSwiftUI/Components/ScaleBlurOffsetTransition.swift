//
//  ScaleBlurOffsetTransition.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 19/03/25.
//

import SwiftUI

//struct ScaleBlurOffsetTransition: Transition {
//    func body(content: Content, phase: TransitionPhase) -> some View {
//        content
//            .scaleEffect(phase.isIdentity ? 1 : 0)
//            .blur(radius: phase.isIdentity ? 0 : 70)
//            .offset(y: phase.isIdentity ? 0 : -UIScreen.main.bounds.height - 200)
//    }
//}

struct ScaleBlurOffsetTransition: Transition {
    func body(content: Content, phase: TransitionPhase) -> some View {
        content // The original content, without blur
            .scaleEffect(phase.isIdentity ? 1 : 0)
            .offset(y: phase.isIdentity ? 0 : -UIScreen.main.bounds.height - 200)
            .blur(radius: phase.isIdentity ? 0 : 50)
    }
}
