import SwiftUI
import AudioToolbox
import AVKit
import CoreMotion
import HealthKit

let defaultShape = RoundedRectangle(cornerRadius: 17)

class ApplicationConstants: ObservableObject {
    
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
    
    
    @Published var annualIncoms: Array<ClosedRange<Int>> = [
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
    public static let whiteGradientInverted = LinearGradient(gradient: Gradient(colors: [ .white, .gray ]), startPoint: .top, endPoint: .bottom)
    public static let silverGradient = LinearGradient(gradient: Gradient(colors: [ .white, .gray ]), startPoint: .top, endPoint: .bottom)
    
    public static var allGradients: [LinearGradient] {
        return [
            lavaGradient,
            orangeGradient,
            greenGradient,
            blueGradient,
            blueGradientInverted,
            thanosGradient,
            whiteGradient,
            applicationGradient,
            redGradient,
            bloodRedGradient,
            cyanGradient,
            waterGradient,
            lavaPurpleGradient,
            goldenGradient,
            brownGradient,
            clearGradient,
            darkBGSameGradient,
            darkBGSameGradientWithOpacityHalf,
            whiteSameGradientWithOpacityPoint8,
            whiteGradientInverted,
            silverGradient
        ]
    }
}


enum Constants: String {
    case id, fullName, username, emailId, password, currentWeight, currentHeight, gender, bodyType, level, goal, dailyPoints, fitnessLevel
}

class ApplicationHelper {
    
    class MotionManager: ObservableObject {
        private let motionManager = CMMotionManager()
        
        @Published var x: Double = .zero
        @Published var y: Double = .zero
        
        
        init() {
            self.motionManager.startDeviceMotionUpdates(to: .main) { [weak self] data, error in
                guard let motion = data?.attitude else { return }
                self?.x = motion.roll
                self?.y = motion.pitch
            }
        }
        
    }
    
    public static func getTimeString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a" // Example: "02:45 PM"
        return formatter.string(from: date)
    }
    
    public func stringToDate(_ dateString: String, format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.date(from: dateString)
    }
    
    public static func getImageFrom(exercise: String, of: Int) -> String {
        switch exercise {
        case "pushups":
            return "https://static.strengthlevel.com/images/exercises/push-ups/push-ups-\(of).jpg"
        case "inclinePushUp":
            return "https://static.strengthlevel.com/images/exercises/incline-push-up/incline-push-up-\(of).jpg"
        case "chestDip":
            return "https://static.strengthlevel.com/images/exercises/dips/dips-\(of).jpg"
        case "benchPress":
            return "https://static.strengthlevel.com/images/exercises/bench-press/bench-press-\(of).jpg"
        case "bicepCurls":
            return "https://static.strengthlevel.com/images/exercises/barbell-curl/barbell-curl-\(of).jpg"
        case "closeGripPushup":
            return "https://static.strengthlevel.com/images/exercises/close-grip-push-up/close-grip-push-up-\(of).jpg"
        case "pullup":
            return "https://static.strengthlevel.com/images/exercises/pull-ups/pull-ups-\(of).jpg"
        case "tricepDip":
            return "https://static.strengthlevel.com/images/exercises/dips/dips-\(of).jpg"
        case "bulgarianSplitSquat":
            return "https://static.strengthlevel.com/images/exercises/bulgarian-split-squat/bulgarian-split-squat-\(of).jpg"
        case "plank":
            return "https://static.strengthlevel.com/images/exercises/bulgarian-split-squat/plank-400.jpg"
        case "mountailClimber":
            return "https://static.strengthlevel.com/images/exercises/mountain-climbers/mountain-climbers-\(of).jpg"
        case "overheadPress":
            return "https://static.strengthlevel.com/images/exercises/shoulder-press/shoulder-press-400.jpg"
        case "bodyWeightSquat":
            return "https://static.strengthlevel.com/images/exercises/bodyweight-squat/bodyweight-squat-400.jpg"
        case "walkingLunges":
            return "https://static.strengthlevel.com/images/exercises/walking-lunge/walking-lunge-400.jpg"
        case "gluteBridge":
            return "https://static.strengthlevel.com/images/exercises/glute-bridge/glute-bridge-400.jpg"
        case "calfRaise":
            return "https://static.strengthlevel.com/images/exercises/bodyweight-calf-raise/bodyweight-calf-raise-400.jpg"
        case "bicycleCrunch":
            return "https://static.strengthlevel.com/images/exercises/bicycle-crunch/bicycle-crunch-400.jpg"
        case "legRaise":
            return "https://static.strengthlevel.com/images/exercises/lying-leg-raise/lying-leg-raise-400.jpg"
        case "russianTwist":
            return "https://static.strengthlevel.com/images/exercises/russian-twist/russian-twist-400.jpg"
        default:
            return ""
        }
    }
    
    
    public static func estimatedCaloriesBurned(steps: Int, weightInKg: Double) -> Double {
        let caloriesPerStep = 0.04 + (weightInKg - 70) * 0.0002 // Adjust based on weight (70kg baseline)
        return Double(steps) * caloriesPerStep
    }
    
    public static func getDay(from: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: from)
    }
    
    public static func getDate(from: Date) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return Int(dateFormatter.string(from: from)) ?? 0
    }
    
    public static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
    
    
    
    public static func getUserFrom(dictionary docData: Dictionary<String, Any>) -> User_t {
        
        let id = docData[Constants.id.rawValue] as! String
        let fullName = docData[Constants.fullName.rawValue] as! String
        let username = docData[Constants.username.rawValue] as! String
        let emailId = docData[Constants.emailId.rawValue] as! String
        let password = docData[Constants.password.rawValue] as! String
        let currentWeight: Double = docData[Constants.currentWeight.rawValue] as! Double
        let currentHeight: Double = docData[Constants.currentHeight.rawValue] as! Double
        let gender: Extras.Gender = Extras.Gender(rawValue: docData[Constants.gender.rawValue] as! String)!
        let bodyType: Extras.BodyType = Extras.BodyType(rawValue: docData[Constants.bodyType.rawValue] as! String)!
        let level: Extras.UserLevel = Extras.UserLevel(rawValue: docData[Constants.level.rawValue] as! String)!
        let goal: Extras.Goal = Extras.Goal(rawValue: docData[Constants.goal.rawValue] as! String)!
        let dailyPoints: Int = docData[Constants.dailyPoints.rawValue] as! Int
        let fitnessLevel: Int = docData[Constants.fitnessLevel.rawValue] as! Int
        
        return .init(id: id, fullName: fullName, username: username, emailId: emailId, password: password, currentWeight: currentWeight, currentHeight: currentHeight, gender: gender, bodyType: bodyType, level: level, goal: goal, dailyPoints: dailyPoints, fitnessLevel: fitnessLevel)
    }
    
    
    enum Sounds: Int {
        case cameraShutter
    }
        
    public static func playSound(of: Sounds) -> Void {
        AudioServicesPlaySystemSound(SystemSoundID(of.rawValue))
    }
    
    public static func dismissKeyboard() -> Void {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
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

class ApplicationBounds {
    public static let backdropZIndex: Double = 999999
    public static let dialogBoxZIndex: Double = 9999999
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

class ApplicationImages {
    public static let calesthenicsWorkoutImage: String = "calesthenics_workout_image"
    public static let weightedWorkoutImage: String = "weighted_workout_image"
    public static let googleIcon: String = "google_icon"
    public static let appleIcon: String = "apple_icon"
    public static let githubIcon: String = "gitub_icon"
    public static let coachImageWithBackground: String = "hero_image_group"
    public static let coachImage: String = "hero_image"
    public static let loginScreenWorkoutImage: String = "generic_workout_image"
    public static let dumbbellImage: String = "Dumbbell"
    public static let tabBarDumbbell: String = "TabBarDumbbell"


    // MARK: Male body type images

    public static let maleSkinny: String = "skinny"
    public static let maleMuscular: String = "upperbody"
    public static let maleSkinnyFat: String = "skinny_fat"
    public static let maleFat: String = "fat"


    // MARK: Female body type iage

    public static let femaleSkinny: String = "fe_skinny"
    public static let femaleMuscular: String = "fe_upperbody"
    public static let femaleSkinnyFat: String = "fe_skinny_fat"
    public static let femaleFat: String = "fe_fat"
    
    
    // MARK: Something else
    public static let smile: String = "smile"
    public static let reverseSmile: String = "reverse_smile"

}

class ApplicationSounds {
    public static let current = ApplicationSounds()
    
    var audioPlayer: AVAudioPlayer?
    
    func time() -> Void {
        guard let soundURL = Bundle.main.url(forResource: "time", withExtension: ".wav") else {
            print("No beep found")
            return
        }
        
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            self.audioPlayer?.play()
        } catch {
            print("Sound 'BEEP' cannot be played!")
        }
        
    }
    func whistle() -> Void {
        guard let soundURL = Bundle.main.url(forResource: "whistle", withExtension: ".mp3") else {
            print("No beep found")
            return
        }
        
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            self.audioPlayer?.play()
        } catch {
            print("Sound 'BEEP' cannot be played!")
        }
        
    }
    
    func playBeep() -> Void {
        guard let soundURL = Bundle.main.url(forResource: "beep", withExtension: ".wav") else {
            print("No beep found")
            return
        }
        
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            self.audioPlayer?.play()
        } catch {
            print("Sound 'BEEP' cannot be played!")
        }
        
    }
    
    func lost() -> Void {
        guard let soundURL = Bundle.main.url(forResource: "lost", withExtension: ".mp3") else {
            print("No beep found")
            return
        }
        
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            self.audioPlayer?.play()
        } catch {
            print("Sound 'BEEP' cannot be played!")
        }
        
    }
    
    func successful() -> Void {
        guard let soundURL = Bundle.main.url(forResource: "duolingo", withExtension: ".mp3") else {
            print("No beep found")
            return
        }
        
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            self.audioPlayer?.play()
        } catch {
            print("Sound 'BEEP' cannot be played!")
        }
        
    }
    
    func medium() -> Void {
        guard let soundURL = Bundle.main.url(forResource: "medium", withExtension: ".mp3") else {
            print("No beep found")
            return
        }
        
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            self.audioPlayer?.play()
        } catch {
            print("Sound 'BEEP' cannot be played!")
        }
        
    }
    
    func unsuccessful() -> Void {
        guard let soundURL = Bundle.main.url(forResource: "not_completed", withExtension: ".mp3") else {
            print("No beep found")
            return
        }
        
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            self.audioPlayer?.play()
        } catch {
            print("Sound 'BEEP' cannot be played!")
        }
        
    }
    
    func playLongBeep() -> Void {
        guard let soundURL = Bundle.main.url(forResource: "beep_long", withExtension: ".wav") else {
            print("No long beep found")
            return
        }
        
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            self.audioPlayer?.play()
        } catch {
            print("Sound 'Long BEEP' cannot be played'")
        }
    }
    
    func click() -> Void {
        
        if let player = audioPlayer, player.isPlaying {
            player.stop()
        }
        guard let soundURL = Bundle.main.url(forResource: "click", withExtension: ".wav") else {
            print("No long beep found")
            return
        }
        
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            self.audioPlayer?.play()
        } catch {
            print("Sound 'Long BEEP' cannot be played'")
        }
    }
    
    func startExercise() -> Void {
        guard let soundURL = Bundle.main.url(forResource: "start_exercise", withExtension: ".mp3") else {
            print("cannot play sound start_exercise")
            return
        }
        
        
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            self.audioPlayer?.play()
        } catch {
            
        }
    }
    
    func comeOnReallyNeedThatMuchTime() -> Void {
        guard let soundURL = Bundle.main.url(forResource: "need_time_res", withExtension: ".mp3") else {
            print("cannot play sound start_exercise")
            return
        }
        
        
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            self.audioPlayer?.play()
        } catch {
            
        }
    }
    
    func playBubble() -> Void {
        guard let soundURL = Bundle.main.url(forResource: "bubble", withExtension: ".wav") else {
            return
        }
        
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            self.audioPlayer?.play()
        } catch {
            
        }
    }
    
    func gayGender() -> Void {
        
        guard let soundURL = Bundle.main.url(forResource: "gay_gender", withExtension: ".mp3") else {
            print("cannot play sound start_exercise")
            return
        }
        
        
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            self.audioPlayer?.play()
        } catch {
            
        }
    }
    
    func completed() -> Void {
        
        guard let soundURL = Bundle.main.url(forResource: "completed", withExtension: ".mp3") else {
            print("cannot play sound start_exercise")
            return
        }
        
        
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            self.audioPlayer?.play()
        } catch {
            
        }
    }
    
    func bubble() -> Void {
        
        guard let soundURL = Bundle.main.url(forResource: "bubble", withExtension: ".wav") else {
            print("cannot play sound start_exercise")
            return
        }
        
        
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            self.audioPlayer?.play()
        } catch {
            
        }
    }
}


enum ApplicationCache: String {
    case cacheForAddFriendsPage
}

func getCacheValue(for cache: ApplicationCache) -> String {
    return cache.rawValue
}

class ApplicationHealthData {
    public static let current = ApplicationHealthData()
    
    @Published var currentDateSteps: Int = .zero
}

class HealthManager: ObservableObject {
    let healthStore = HKHealthStore()
    
    
    init() {
        let steps = HKQuantityType(.stepCount)
        
        let healthTypes: Set = [steps]
        Task {
            do {
                try await self.healthStore.requestAuthorization(toShare: [], read: healthTypes)
            } catch {
                print("Error fetching health data")
            }
        }
        
    }
    
//    func getStepsToday() -> Int {
//        var stepCount: Int = .zero
//        let steps = HKQuantityType(.stepCount)
//        let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: Date()), end: Date())
//        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, res, error in
//            guard let res = res, let qualtity = res.sumQuantity(), error == nil else { return  }
//            print(Int(qualtity.doubleValue(for: .count())))
//            
//            stepCount = Int(qualtity.doubleValue(for: .count()))
//            print("From closure: ", stepCount)
//        }
//        
//        
//        self.healthStore.execute(query)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            print("From function: ", stepCount)
//        }
//        
//        return stepCount
//    }
    
    func getStepsToday() async -> Int {
        let steps = HKQuantityType(.stepCount)
        let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: Date()), end: Date(), options: .strictEndDate)
        
        return await withCheckedContinuation { continuation in
            let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, result, error in
                guard let result = result, let quantity = result.sumQuantity(), error == nil else {
                    continuation.resume(returning: 0)
                    return
                }
                
                let stepCount = Int(quantity.doubleValue(for: .count()))
                continuation.resume(returning: stepCount)
            }
            
            self.healthStore.execute(query)
        }
    }
}
