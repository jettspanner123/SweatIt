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

extension View {
    
    func buttonConfiguration(_ background: LinearGradient = ApplicationLinearGradient.redGradient) -> some View {
        
        self
            .frame(maxWidth: .infinity)
            .frame(height: 45)
            .background(background)
            .clipShape(defaultShape)
    }
    func takeMaxWidthLeading() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    
    
    func applicationDropDownButton(_ background: LinearGradient = ApplicationLinearGradient.darkBGSameGradientWithOpacityHalf, height: CGFloat = 45) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(minHeight: height)
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            .background(background)
            .overlay {
                defaultShape
                    .stroke(.white.opacity(0.18))
            }
            .clipShape(defaultShape)
    }
}

extension Color {
    // Initialize with hex string (with or without # prefix)
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    // Initialize with hex integer value
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: alpha
        )
    }
    
    // Convert Color to hex string
    var hexString: String {
        let components = UIColor(self).cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0
        
        let hexString = String(
            format: "#%02lX%02lX%02lX",
            lroundf(Float(r * 255)),
            lroundf(Float(g * 255)),
            lroundf(Float(b * 255))
        )
        return hexString
    }
    
    // Return contrasting text color (black or white) based on background color
    var contrastingTextColor: Color {
        let components = UIColor(self).cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0
        
        // Luminance formula to determine text color
        let luminance = 0.299 * r + 0.587 * g + 0.114 * b
        return luminance > 0.5 ? Color.black : Color.white
    }
}

struct BounceEffectModifier: ViewModifier {
    @State private var isTapped: Bool = false
    var closure: () -> Void = {}
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isTapped ? 0.95 : 1)
            .onTapGesture {
                closure() // Execute the closure passed in
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    isTapped = true
                    
                    // Reset the scale after the bounce effect
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        isTapped = false
                    }
                }
            }
    }
}

extension View {
    func addBounceEffectOnTap(closure: @escaping () -> Void) -> some View {
        self.modifier(BounceEffectModifier(closure: closure))
    }
}

