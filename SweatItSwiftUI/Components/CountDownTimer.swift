import SwiftUI

struct CountDownTimer: View {
    @EnvironmentObject var appState: ApplicationStates
    
    
    @State var countdownNumber: Int = 6
    var isZero: Bool {
        return self.countdownNumber == -1
    }
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
           
            if self.countdownNumber > 0 {
                Text(String(self.countdownNumber))
                    .font(.custom(ApplicationFonts.oswaldSemiBold, size: 70))
                    .foregroundStyle(.white)
                    .contentTransition(.numericText(value: Double(self.countdownNumber)))
                    .animation(.snappy, value: Double(self.countdownNumber))
                    .onReceive(self.timer) { time in
                        if self.countdownNumber > 0 {
                            self.countdownNumber -= 1
                        } else {
                            self.timer.upstream.connect().cancel()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation {
                                    self.appState.workoutStatus = .started
                                }
                            }
                        }
                    }
                    .transition(.offset(x: UIScreen.main.bounds.width))
            } else {
                Text("Let's Go")
                    .font(.custom(ApplicationFonts.oswaldSemiBold, size: 60))
                    .foregroundStyle(.white)
                    .animation(.smooth, value: self.countdownNumber)
                    .transition(.offset(x: -UIScreen.main.bounds.width))
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onReceive(self.timer) { timer_t in
            if self.countdownNumber == -1 {
                withAnimation {
                    self.appState.workoutStatus = .started
                }
                self.timer.upstream.connect().cancel()
            }
        }
        .sensoryFeedback(.impact, trigger: self.countdownNumber)
        .onChange(of: self.countdownNumber) {
            if self.countdownNumber == 0 {
                ApplicationSounds.current.playLongBeep()
            } else {
                ApplicationSounds.current.playBeep()
            }
        }
    }
}
