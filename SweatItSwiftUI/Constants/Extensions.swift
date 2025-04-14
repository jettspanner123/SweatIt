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

struct VibrateEffectModifier: ViewModifier {
    @State private var buttonTapCount: Int = 0
    var closure: () -> Void = {}
    
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                closure() // Execute the closur33e passed in
                withAnimation(.bouncy(duration: 0.25)) {
                    self.buttonTapCount += 1
                }
            }
            .sensoryFeedback(.impact, trigger: self.buttonTapCount)
    }
}

struct VibrateScaleEffectModifier: ViewModifier {
    @State private var buttonTapped: Bool = false
    @State private var buttonTapCount: Int = 0
    var closure: () -> Void = {}
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(self.buttonTapped ? 0.8 : 1)
            .onTapGesture {
                closure()
                self.buttonTapCount += 1
                
                withAnimation {
                    self.buttonTapped = true
                }
            }
            .onChange(of: self.buttonTapped) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    if self.buttonTapped {
                        withAnimation {
                            self.buttonTapped = false
                        }
                    }
                }
            }
            .sensoryFeedback(.impact, trigger: self.buttonTapCount)
    }
}



struct ScaleEffectModifier: ViewModifier {
    @State private var buttonTapped: Bool = false
    var closure: () -> Void = {}
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(self.buttonTapped ? 0.8 : 1)
            .onTapGesture {
                closure()
                
                withAnimation {
                    self.buttonTapped = true
                }
            }
            .onChange(of: self.buttonTapped) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    if self.buttonTapped {
                        withAnimation {
                            self.buttonTapped = false
                        }
                    }
                }
            }
    }
}



extension View {
    func onTapWithVibration(closure: @escaping () -> Void) -> some View {
        self.modifier(VibrateEffectModifier(closure: closure))
    }
    
    func onTapWithScale(closure: @escaping () -> Void) -> some View {
        self.modifier(ScaleEffectModifier(closure: closure))
    }
    
    func onTapWithScaleVibrate(closure: @escaping () -> Void) -> some View {
        self.modifier(VibrateScaleEffectModifier(closure: closure))
    }
    
    func isBottomButton() -> some View {
        self
            .offset(y: UIScreen.main.bounds.height / 2 - (75))
    }
    
}

extension CustomTextField {
    func isEditable() -> some View {
        self
            .overlay {
                HStack {
                    Image(systemName: "square.and.pencil")
                        .foregroundStyle(.white.opacity(0.5))
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal, 15)
            }
    }
}

extension BottomBlur {
    func toBottom() -> some View {
        self
            .offset(y: UIScreen.main.bounds.height - (55 * 2.1))
    }
}


extension Text {
    
    func dropDownItem() -> some View {
        self
            .font(.system(size: 15, weight: .regular, design: .rounded))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 35)
    }
    func bottomDialogBoxHeading() -> some View {
        self
            .font(.custom(ApplicationFonts.oswaldRegular, size: 25))
            .foregroundStyle(.white)
            .takeMaxWidthLeading()
    }
    
    func bottomDialogBoxSubHeading() -> some View {
        self
            .font(.system(size: 15, weight: .regular, design: .rounded))
            .foregroundStyle(.white)
            .takeMaxWidthLeading()
            .padding(.top, 1)
        
    }
    
    func bottomDialogBoxBodyText() -> some View {
        self
            .font(.system(size: 15, weight: .regular, design: .rounded))
            .foregroundStyle(.white.opacity(0.5))
            .takeMaxWidthLeading()
    }
}

extension Date {
    func add(_ day: Int) -> Date {
        return self.addingTimeInterval(TimeInterval(ONE_DAY * day))
    }
}
