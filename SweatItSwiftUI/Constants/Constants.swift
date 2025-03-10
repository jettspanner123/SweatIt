import SwiftUI

let defaultShape = RoundedRectangle(cornerRadius: 17)

class ApplicationLinearGradient {
    public static let lavaGradient = LinearGradient(gradient: Gradient(colors: [.appLavaTwo, .appLavaOne]), startPoint: .top, endPoint: .bottom)
    public static let orangeGradient = LinearGradient(gradient: Gradient(colors: [.appOrangeLight, .appOrangeDark]), startPoint: .top, endPoint: .bottom)
    public static let greenGradient = LinearGradient(gradient: Gradient(colors: [.appGreenLight, .appGreenDark]), startPoint: .top, endPoint: .bottom)
    public static let blueGradient = LinearGradient(gradient: Gradient(colors: [.appBlueDark, .appBlueLight]), startPoint: .top, endPoint: .bottom)
    public static let thanosGradient = LinearGradient(gradient: Gradient(colors: [.appThanosLight, .appThanosDark]), startPoint: .top, endPoint: .bottom)
    public static let whiteGradient = LinearGradient(gradient: Gradient(colors: [.gray, .white]), startPoint: .top, endPoint: .bottom)
    public static let applicationGradient = LinearGradient(gradient: Gradient(colors: [.darkBG, .black]), startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x: 0.5, y: 1.6))
    public static let redGradient = LinearGradient(gradient: Gradient(colors: [.appRedLight, .appRedDark]), startPoint: .top, endPoint: .bottom)
    public static let bloodRedGradient = LinearGradient(gradient: Gradient(colors: [.appBloodRedLight, .appBloodRedDark]), startPoint: .top, endPoint: .bottom)
    public static let cyanGradient = LinearGradient(gradient: Gradient(colors: [.appCyanLight, .appCyanDark]), startPoint: .top, endPoint: .bottom)
    public static let waterGradient = LinearGradient(gradient: Gradient(colors: [.appWaterLight, .appWaterDark]), startPoint: .top, endPoint: .bottom)
    public static let lavaPurpleGradient = LinearGradient(gradient: Gradient(colors: [.appLavaPurpleOne, .appLavaPurpleTwo]), startPoint: .top, endPoint: .bottom)

}

class ApplicationHelper {
    
    public static func formatSeconds(seconds: Int) -> String {
        if seconds < 3600 {
            let minutes = Double(seconds) / 60
            return String(format: "%.0f MIN", minutes)
        } else {
            let hours = Double(seconds) / 3600
            return String(format: "%.1f HR", hours)
        }
    }
    
    public static func getMinutes(_ time: TimeInterval) -> Date {
        .now.addingTimeInterval(time * 60)
    }
    
    public static func getSeconds(_ time: TimeInterval) -> Date {
        .now.addingTimeInterval(time)
    }
    
    public static func getHours(_ time: TimeInterval) -> Date {
        .now.addingTimeInterval(time * 60 * 60)
    }
    
    public static func formatDateToHumanReadable(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium 
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: date)
    }
    
    
    public static func impactOccured(style: UIImpactFeedbackGenerator.FeedbackStyle) -> Void {
        let impactEnginge = UIImpactFeedbackGenerator(style: style)
        impactEnginge.prepare()
        impactEnginge.impactOccurred()
    }
}

class ApplicationPadding {
    public static let mainScreenVerticalPadding: Double = 90
    public static let mainScreenHorizontalPadding: Double = 15
}

class ApplicationFonts {
    public static let oswaldRegular = "Oswald-Regular"
    public static let oswaldMedium = "Oswald-Medium"
    public static let oswaldBold = "Oswald-Bold"
    
    public static let poppinsBold = "Poppins-Bold"
    public static let poppinsLight = "Poppins-Light"
    public static let poppinsMedium = "Poppins-Medium"
    
    public static let robotoCondensedLight = "RobotoCondensed-Light"
    public static let robotoCondensedMedium = "RobotoCondensed-Medium"
    public static let robotoCondensedRegular = "RobotoCondensed-Regular"

}
