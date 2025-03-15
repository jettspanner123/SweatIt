import SwiftUI

struct CountDownTimer: View {
    
    @State var countdownNumber: Int = 5
    var isZero: Bool {
        return self.countdownNumber == 0
    }
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
           
            if self.countdownNumber > 0 {
                Text(String(self.countdownNumber))
                    .font(.custom(ApplicationFonts.oswaldSemiBold, size: 70))
                    .foregroundStyle(.white)
                    .onReceive(self.timer) { time in
                        if self.countdownNumber > 0 {
                            self.countdownNumber -= 1
                        } else {
                            self.timer.upstream.connect().cancel()
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
    }
}
