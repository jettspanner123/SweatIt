//
//  SweatItSwiftUIApp.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 09/03/25.
//

import SwiftUI
import SwiftData

class ApplicationStates: ObservableObject {
    @Published var userData: SignUpUserDataStore = .init(username: "", password: "", age: 0, gender: .none, height: .zero, weight: .zero, bodyType: .none, activeDaysAWeek: 0, activeHoursADay: 1, region: "", foodBudged: .zero)
    
    @Published var isError: Bool = false
    
    public func showError() -> Void {
        withAnimation {
            self.isError = true
        }
        
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    self.isError = false
                }
            }
    }
}

@main
struct SweatItSwiftUIApp: App {
    
    @StateObject var appStates = ApplicationStates()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environmentObject(self.appStates)
    }
}
