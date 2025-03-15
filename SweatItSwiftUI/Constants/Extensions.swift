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
    func takeMaxWidthLeading() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
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

extension UIImage {
    func extractDominantColors(count: Int = 2) -> [Color] {
        // Convert to CGImage
        guard let cgImage = self.cgImage else { return [] }
        
        // Create the color space
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // Create bitmap context
        let width = cgImage.width
        let height = cgImage.height
        let bytesPerPixel = 4
        let bytesPerRow = bytesPerPixel * width
        let bitsPerComponent = 8
        
        var rawData = [UInt8](repeating: 0, count: width * height * bytesPerPixel)
        
        guard let context = CGContext(data: &rawData,
                                     width: width,
                                     height: height,
                                     bitsPerComponent: bitsPerComponent,
                                     bytesPerRow: bytesPerRow,
                                     space: colorSpace,
                                     bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue) else {
            return []
        }
        
        // Draw the image in the bitmap context
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        // Create a dictionary to count color occurrences
        var colorCounts: [UInt32: Int] = [:]
        
        // Iterate through pixels
        for y in 0..<height {
            for x in 0..<width {
                let byteIndex = (bytesPerRow * y) + (bytesPerPixel * x)
                
                // Skip pixels with high transparency
                if rawData[byteIndex + 3] < 128 {
                    continue
                }
                
                // Pack RGB values into a UInt32 for easy dictionary handling
                let red = UInt32(rawData[byteIndex])
                let green = UInt32(rawData[byteIndex + 1])
                let blue = UInt32(rawData[byteIndex + 2])
                
                // Skip very dark colors
                if red + green + blue < 100 {
                    continue
                }
                
                // Reduce color space to make clustering easier
                let quantizedRed = red / 16 * 16
                let quantizedGreen = green / 16 * 16
                let quantizedBlue = blue / 16 * 16
                
                let colorKey = (quantizedRed << 16) | (quantizedGreen << 8) | quantizedBlue
                
                // Increment count for this color
                colorCounts[colorKey, default: 0] += 1
            }
        }
        
        // Sort colors by occurrence count
        let sortedColors = colorCounts.sorted { $0.value > $1.value }
        
        // Convert top colors back to Color objects
        let result = sortedColors.prefix(count).map { colorKey, _ in
            let red = Double((colorKey >> 16) & 0xFF) / 255.0
            let green = Double((colorKey >> 8) & 0xFF) / 255.0
            let blue = Double(colorKey & 0xFF) / 255.0
            
            return Color(red: red, green: green, blue: blue)
        }
        
        return result
    }
}
