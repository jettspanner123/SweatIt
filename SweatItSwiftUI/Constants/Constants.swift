import SwiftUI

let defaultShape = RoundedRectangle(cornerRadius: 17)

class ApplicationConstants {
    
    struct SignupStateObject {
        var username: String = ""
        var password: String = ""
        var confirmPassword: String = ""
        var dob: Date = .now
        var gender: Extras.Gender = .none
        var height: Double = .zero
        var weight: Double = .zero
        var bodyType: Extras.BodyType = .none
        var userLevel: Extras.UserLevel = .none
        var goalType: Extras.Goal = .none
        
    }
    
    
    public static let minimumUserAge: Double = 18
    public static let heightScrollViewStepSize: Int = 1
    public static let heightScrollViewMaxLimit: Int = 270
    public static let weightScrollViewMaxLimit: Int = 1400
    
    public static let workoutTimeEachDatMaxLimit: Int = 8
    
    
    public static let annualIncoms: Array<ClosedRange<Int>> = [
        .init(uncheckedBounds: (0, 5)),
        .init(uncheckedBounds: (5, 10)),
        .init(uncheckedBounds: (10, 15)),
    ]
}

class ApplicationLinearGradient {
    public static let lavaGradient = LinearGradient(gradient: Gradient(colors: [.appLavaTwo, .appLavaOne]), startPoint: .top, endPoint: .bottom)
    public static let orangeGradient = LinearGradient(gradient: Gradient(colors: [.appOrangeLight, .appOrangeDark]), startPoint: .top, endPoint: .bottom)
    public static let greenGradient = LinearGradient(gradient: Gradient(colors: [.appGreenLight, .appGreenDark]), startPoint: .top, endPoint: .bottom)
    public static let blueGradient = LinearGradient(gradient: Gradient(colors: [.appBlueDark, .appBlueLight]), startPoint: .top, endPoint: .bottom)
    public static let blueGradientInverted = LinearGradient(gradient: Gradient(colors: [.appBlueLight, .appBlueDark]), startPoint: .top, endPoint: .bottom)
    public static let thanosGradient = LinearGradient(gradient: Gradient(colors: [.appThanosLight, .appThanosDark]), startPoint: .top, endPoint: .bottom)
    public static let whiteGradient = LinearGradient(gradient: Gradient(colors: [.gray, .white]), startPoint: .top, endPoint: .bottom)
    public static let applicationGradient = LinearGradient(gradient: Gradient(colors: [.darkBG, .black]), startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x: 0.5, y: 1.6))
    public static let redGradient = LinearGradient(gradient: Gradient(colors: [.appRedLight, .appRedDark]), startPoint: .top, endPoint: .bottom)
    public static let bloodRedGradient = LinearGradient(gradient: Gradient(colors: [.appBloodRedLight, .appBloodRedDark]), startPoint: .top, endPoint: .bottom)
    public static let cyanGradient = LinearGradient(gradient: Gradient(colors: [.appCyanLight, .appCyanDark]), startPoint: .top, endPoint: .bottom)
    public static let waterGradient = LinearGradient(gradient: Gradient(colors: [.appWaterLight, .appWaterDark]), startPoint: .top, endPoint: .bottom)
    public static let lavaPurpleGradient = LinearGradient(gradient: Gradient(colors: [.appLavaPurpleOne, .appLavaPurpleTwo]), startPoint: .top, endPoint: .bottom)
    public static let goldenGradient = LinearGradient(gradient: Gradient(colors: [.appGoldLight, .appGoldDark]), startPoint: .top, endPoint: .bottom)
    public static let brownGradient = LinearGradient(gradient: Gradient(colors: [.appBrownLight, .appBrownDark]), startPoint: .top, endPoint: .bottom)
    public static let clearGradient = LinearGradient(gradient: Gradient(colors: [.clear, .clear]), startPoint: .top, endPoint: .bottom)
    public static let darkBGSameGradient = LinearGradient(gradient: Gradient(colors: [.darkBG, .darkBG]), startPoint: .top, endPoint: .bottom)
    public static let darkBGSameGradientWithOpacityHalf = LinearGradient(gradient: Gradient(colors: [.darkBG.opacity(0.54), .darkBG.opacity(0.54)]), startPoint: .top, endPoint: .bottom)
    public static let whiteSameGradientWithOpacityPoint8 = LinearGradient(gradient: Gradient(colors: [.white.opacity(0.08), .white.opacity(0.08)]), startPoint: .top, endPoint: .bottom)
    

}

class ApplicationHelper {
    
    public static func convertCmToFeetAndInches(cm: Double) -> String {
        let inchesTotal = cm / 2.54
        let feet = Int(inchesTotal) / 12
        let inches = Int(inchesTotal) % 12
        return "\(feet) ft \(inches) in"
    }
    
    public static func inchesToCentimeters(inches: Int) -> Int {
        let centimeters = Double(inches) * 2.54
        return Int(centimeters)
    }
    
    public static func formatSeconds(seconds: Int) -> String {
        if seconds < 3600 {
            let minutes = Double(seconds) / 60
            return String(format: "%.0f MIN", minutes)
        } else {
            let hours = Double(seconds) / 3600
            return String(format: "%.1f HR", hours)
        }
    }
    
    public static func toKg(lbs: CGFloat) -> CGFloat {
        return lbs * 0.453592
    }
    
    public static func toMeter(height: CGFloat) -> Int {
        let meters = height / 100
        return Int(meters)
    }
    
    public static func inchesToFeetAndInches(inches: Int) -> String {
        let feet = inches / 12
        let remainingInches = inches % 12
        return "\(feet)ft \(remainingInches)in"
    }
    
    public static func getTimeFromDate(_ date: Date) -> String {
        
        let calendar = Calendar.current
        let now = Date()
        
        let components = calendar.dateComponents([.second, .minute, .hour, .day, .month, .year], from: now, to: date)
        
        if let year = components.year, year > 0 {
            return "\(year) year\(year > 1 ? "s" : "")"
        } else if let month = components.month, month > 0 {
            return "\(month) month\(month > 1 ? "s" : "")"
        } else if let day = components.day, day > 0 {
            return "\(day) day\(day > 1 ? "s" : "")"
        } else if let hour = components.hour, hour > 0 {
            return "\(hour) hour\(hour > 1 ? "s" : "")"
        } else if let minute = components.minute, minute > 0 {
            return "\(minute) min\(minute > 1 ? "s" : "")"
        } else if let second = components.second, second > 0 {
            return "\(second) sec\(second > 1 ? "s" : "")"
        } else {
            return "Just now"
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
    
    public static func formatDateToHumanReadableWithoutTime(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        return dateFormatter.string(from: date)
    }
    
    
    public static func impactOccured(style: UIImpactFeedbackGenerator.FeedbackStyle) -> Void {
        let impactEnginge = UIImpactFeedbackGenerator(style: style)
        impactEnginge.prepare()
        impactEnginge.impactOccurred()
    }
    
    
    class UserHelper {
        public static var currenr = UserHelper()
        
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
    public static let oswaldSemiBold = "Oswald-SemiBold"

    
    public static let poppinsBold = "Poppins-Bold"
    public static let poppinsLight = "Poppins-Light"
    public static let poppinsMedium = "Poppins-Medium"
    
    public static let robotoCondensedLight = "RobotoCondensed-Light"
    public static let robotoCondensedMedium = "RobotoCondensed-Medium"
    public static let robotoCondensedRegular = "RobotoCondensed-Regular"

}
