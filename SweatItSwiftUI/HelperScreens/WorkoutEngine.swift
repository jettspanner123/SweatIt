//
//  WorkoutEngine.swift
//  SweatItSwiftUI
//
//  Created by Uddeshya Singh on 13/04/25.
//

import SwiftUI

struct WorkoutEngine: View {
    
    @EnvironmentObject var appStates: ApplicationStates
    
    var workout: Workout_t
    
    @State var workoutArrayIndex: Int = 0
    @State var startTiming: Int = 0
    
    @State var isMenuOpen: Bool = false
    @State var menuPageTranslation: CGSize = .zero
    
    @State var isExitDialogOpen: Bool = false
    
    @State var completedExercises: Set<Exercise_t> = []
    @State var showTimerScreen: Bool = false
    
    @State var secondsToElapse: Int = 20
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    
    func updateTimer() -> Void {
        withAnimation {
            self.startTiming += 1
        }
    }
    
    func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
    
    func markWorkoutCompleted() -> Void {
        if self.workoutArrayIndex == self.workout.exercises.count - 1 {
            
            self.appStates.dailyEvents.workoutsDone.append(self.workout)
            withAnimation {
                self.appStates.workoutStatus = .none
            }
            
            ApplicationSounds.current.completed()

            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.appStates.workoutStatus = .ended
                }
                
                ApplicationSounds.current.playBubble()
            }
            return
        }
        
        self.completedExercises.insert(self.workout.exercises[self.workoutArrayIndex])
        withAnimation {
            self.showTimerScreen = true
        }
        ApplicationSounds.current.whistle()
    }
    
    var body: some View {
        NavigationStack {
            ScreenBuilder {
                
                if self.isExitDialogOpen {
                    DialogBox {
                       Text("Wanna Quit? 🤡")
                            .bottomDialogBoxHeading()
                        Text("If you quit now all your progress will be lost, which is a shame!")
                            .bottomDialogBoxBodyText()
                        
                        HStack {
                            SimpleButton(content: {
                                Text("Quit")
                                    .font(.system(size: 13, weight: .medium, design: .rounded))
                                    .foregroundStyle(.white)
                            }, backgroundLinearGradient: ApplicationLinearGradient.thanosGradient, some: {
                                withAnimation {
                                    self.appStates.workoutStatus = .none
                                }
                                
                                ApplicationSounds.current.lost()
                            })
                            
                            SimpleButton(content: {
                                Text("Stay")
                                    .font(.system(size: 13, weight: .medium, design: .rounded))
                                    .foregroundStyle(.white)
                            }, backgroundLinearGradient: ApplicationLinearGradient.redGradient, some: {
                                withAnimation {
                                    self.isExitDialogOpen = false
                                }
                            })
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top)
                        
                    }
                }
                
                if self.isExitDialogOpen {
                    CustomBackDrop()
                }
                
                if self.showTimerScreen {
                    self.TimerScreen
                        .zIndex(2000)
                        .transition(.offset(y: UIScreen.main.bounds.height))
                }
                
                
                if self.isMenuOpen {
                    self.MenuScreen
                }
                
                
                
                
                
                // MARK: Bottom card parent holder
                VStack {
                    
                    
                    
                    
                    // MARK: Bottom card
                    VStack {
                        
                        
                        HStack {
                            Text(self.workout.exercises[self.workoutArrayIndex].exerciseName)
                                .font(.system(size: 20, weight: .medium, design: .rounded))
                                .foregroundStyle(.white)
                                .contentTransition(.identity)
                            
                            Spacer()
                            
                            Text("x15")
                                .font(.custom(ApplicationFonts.oswaldRegular, size: 25))
                                .foregroundStyle(.white)
                        }
                        .frame(maxWidth: .infinity)
                        
                        
                        // MARK: Exercise Change buttons
                        HStack {
                            // MARK: Previous exercise button
                            
                            HStack {
                                if self.workoutArrayIndex != 0 {
                                    Image(systemName: "chevron.left")
                                        .foregroundStyle(.white)
                                        .transition(.blurReplace)
                                    
                                } else {
                                    Image(systemName: "xmark")
                                        .foregroundStyle(.white)
                                        .transition(.blurReplace)
                                    
                                }
                                
                            }
                            .frame(width: 50, height: 50)
                            .overlay {
                                Circle()
                                    .stroke(.white.opacity(0.18))
                            }
                            .background(.white.opacity(0.08), in: Circle())
                            .opacity(self.workoutArrayIndex == 0 ? 0.25 : 1)
                            .onTapGesture {
                                withAnimation {
                                    if self.workoutArrayIndex > 0 {
                                        self.workoutArrayIndex -= 1
                                    }
                                }
                            }
                            
                            
                            
                            
                            let exerciseToCheck: Exercise_t = self.workout.exercises[self.workoutArrayIndex]
                            // MARK: Mark exercise complete button
                            HStack {
                                if self.workoutArrayIndex == self.workout.exercises.count - 1 {
                                    Text("Complete Workout")
                                        .font(.system(size: 13, weight: .medium, design: .rounded))
                                        .foregroundStyle(.white)
                                        .transition(.blurReplace)
                                } else {
                                    Text(self.completedExercises.contains(exerciseToCheck) ? "Marked Completed" : "Mark Exercise Done")
                                        .font(.system(size: 13, weight: .medium, design: .rounded))
                                        .foregroundStyle(.white)
                                        .transition(.blurReplace)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(self.completedExercises.contains(exerciseToCheck) ? ApplicationLinearGradient.redGradient : ApplicationLinearGradient.blueGradientInverted, in: Capsule())
                            .onTapWithVibration {
                                self.markWorkoutCompleted()
                            }
                            
                            
                            
                            
                            
                            
                            // MARK: Next Exercise button
                            HStack {
                                if self.workoutArrayIndex != self.workout.exercises.count - 1 {
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.white)
                                        .transition(.blurReplace)
                                    
                                } else {
                                    Image(systemName: "xmark")
                                        .foregroundStyle(.white)
                                        .transition(.blurReplace)
                                    
                                }
                                
                            }
                            .frame(width: 50, height: 50)
                            .overlay {
                                Circle()
                                    .stroke(.white.opacity(0.18))
                            }
                            .background(.white.opacity(0.08), in: Circle())
                            .opacity(self.workoutArrayIndex == self.workout.exercises.count - 1 ? 0.25 : 1)
                            .onTapGesture {
                                withAnimation {
                                    if self.workoutArrayIndex < self.workout.exercises.count - 1 {
                                        self.workoutArrayIndex += 1
                                    }
                                }
                            }
                            
                            
                            
                            
                        }
                        .frame(maxWidth: .infinity)
                        
                        
                        SimpleButton(content: {
                            Text("See All Exercises")
                                .font(.system(size: 13, weight: .medium, design: .rounded))
                                .foregroundStyle(.white)
                        }, backgroundLinearGradient: LinearGradient(gradient: Gradient(colors: [.white.opacity(0.08), .white.opacity(0.08)]), startPoint: .top, endPoint: .bottom), some: {
                            withAnimation {
                                self.isMenuOpen = true
                            }
                        })
                        .padding(.top, 15)
                        
                        
                        Spacer()
                            .frame(maxWidth: .infinity)
                            .frame(height: 20)
                        
                    }
                    .padding(25)
                    .frame(maxWidth: .infinity)
                    .background(.darkBG, in: UnevenRoundedRectangle(cornerRadii: .init(topLeading: 17, topTrailing: 17)))
                    .ignoresSafeArea()
                    
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                .ignoresSafeArea()
                .zIndex(10)
                
                
                
                
                // MARK: Image area
                
                let exerciseImage: String = self.workout.exercises[self.workoutArrayIndex].image
                VStack {
                    HStack {
                        AsyncImage(url: URL(string: ApplicationHelper.getImageFrom(exercise: exerciseImage, of: 400))) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .tint(.darkBG)
                            case .success(let image):
                                image
                                    .resizable()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            case .failure:
                                Text("Image not found!")
                            @unknown default:
                                Text("Some Error Has been found")
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 400)
                    .padding(.bottom, ApplicationPadding.mainScreenVerticalPadding + 70)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
                .background(.white)
                
                
                
                
                
                // MARK: Top navigatino bar
                VStack {
                    self.WorkoutEngineTopNavigationBar
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.top, 20)
            }
            .onReceive(self.timer) { timerValue in
                self.updateTimer()
                
                
                
                if self.showTimerScreen {
                    if self.secondsToElapse > 0 {
                        self.secondsToElapse -= 1
                        ApplicationSounds.current.time()
                    }
                    
                    if self.secondsToElapse == 0 {
                        self.workoutArrayIndex += 1
                        withAnimation {
                            self.showTimerScreen = false
                        }
                        self.secondsToElapse = 20
                    }
                    
                }
            }
            .sensoryFeedback(.impact, trigger: self.workoutArrayIndex)
        }
    }
    
    var TimerScreen: some View {
        VStack {
            
            
            VStack(spacing: 0) {
                Text(self.formatTime(self.secondsToElapse) + "s")
                    .font(.custom(ApplicationFonts.oswaldRegular, size: 60))
                    .foregroundStyle(.white)
                    .contentTransition(.numericText(value: Double(self.secondsToElapse)))
                    .animation(.snappy, value: Double(self.secondsToElapse))
                
                HStack {
                    Text("+20s")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 25)
                        .padding(.vertical, 8)
                        .background(.white.opacity(0.18), in: Capsule())
                        .onTapGesture {
                            withAnimation {
                                self.secondsToElapse += 20
                            }
                        }
                    
                    Text("Skip")
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundStyle(.appBlueLight)
                        .padding(.horizontal, 25)
                        .padding(.vertical, 8)
                        .background(.white, in: Capsule())
                        .onTapGesture {
                            withAnimation {
                                self.secondsToElapse = 0
                            }
                        }
                }
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            
            VStack {
                Text("Next \(self.workoutArrayIndex+1)/\(self.workout.exercises.count)")
                    .font(.system(size: 15, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
                    .takeMaxWidthLeading()
                    .offset(y: 10)
                
                HStack {
                    
                    let nextWorkoutImage: String = self.workoutArrayIndex < self.workout.exercises.count - 1 ? self.workout.exercises[self.workoutArrayIndex+1].exerciseName : self.workout.exercises[self.workoutArrayIndex].exerciseName
                    
                    Text(nextWorkoutImage)
                        .font(.system(size: 23, weight: .medium, design: .rounded))
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    Text("x5")
                        .font(.custom(ApplicationFonts.oswaldRegular, size: 30))
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                    
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            .offset(y: 20)
            
            
            
            
            // MARK: NExt exercise preview view
           
            let currentExerciseImage: String = self.workout.exercises[self.workoutArrayIndex+1].image
            VStack {
                AsyncImage(url: URL(string: ApplicationHelper.getImageFrom(exercise: currentExerciseImage, of: 400))) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .tint(.darkBG)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    case .failure:
                        Text("Failed To Load Image")
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundStyle(.darkBG)
                    @unknown default:
                        Text("An Unknow Error Occured")
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundStyle(.darkBG)
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 350)
            .background(.white, in: UnevenRoundedRectangle(cornerRadii: .init(topLeading: 17, topTrailing: 17)))
            .ignoresSafeArea()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ApplicationLinearGradient.blueGradientInverted)
        .ignoresSafeArea()
    }
    
    var MenuScreen: some View {
        ZStack(alignment: .top) {
            
            
            
            // MARK: Menu heading background blur
            HStack {
                
                
            }
            .frame(maxWidth: .infinity)
            .frame(height: 150)
            .background(AppBackgroundBlur(radius: 10, opaque: false))
            .padding(.top, -35)
            .padding(.bottom, 15)
            .padding(.horizontal, -25)
            .ignoresSafeArea()
            .zIndex(9)
            
            
            
            // MARK: Menu heading
            HStack {
                
                HStack {
                    Text("Menu")
                        .font(.system(size: 25, weight: .light, design: .rounded))
                        .foregroundStyle(.white)
                        .padding(.top, 50)
                        .frame(maxWidth: .infinity)
                        .overlay(alignment: .leading) {
                            Image(systemName: "xmark")
                                .foregroundStyle(.white)
                                .padding()
                                .padding(.top, 50)
                                .padding(.leading)
                                .background(.white.opacity(0.001))
                                .onTapGesture {
                                    withAnimation {
                                        self.isMenuOpen = false
                                    }
                                }
                        }
                }
                .padding(.top, 25)
                .zIndex(.infinity)
                .transition(.blurReplace.combined(with: .offset(y: -100)))
                
            }
            .frame(maxWidth: .infinity)
            .zIndex(15)
            
            
            
            // MARK: Exercise view
            ScrollView {
                
                VStack {
                    
                    SectionHeader(text: "Workout Progress")
                    
                    GeometryReader { geometryProxy in
                        let progressBarWidth = geometryProxy.size.width
                        let doubledCountOfExercisesDone: Double = Double(self.completedExercises.count)
                        let doubledCountOfExercisesInTotal: Double = Double(self.workout.exercises.count)
                        let progressBarPoints = doubledCountOfExercisesDone / doubledCountOfExercisesInTotal
                        
                        HStack {
                            HStack {
                                Text(String(format: "%.f%%", progressBarPoints * 100))
                                    .font(.system(size: 10, weight: .bold, design: .rounded))
                                    .foregroundStyle(.white)
                            }
                            .padding(.horizontal, 5)
                            .frame(width: progressBarWidth * progressBarPoints, height: 25, alignment: .trailing)
                            .background(ApplicationLinearGradient.blueGradientInverted)
                            .onTapGesture {
                                print(progressBarWidth, progressBarPoints, self.completedExercises.count, self.workout.exercises.count)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 25)
                        .background(.appBlueDark.opacity(0.5), in: RoundedRectangle(cornerRadius: 4))
                    }
                    
                    SectionHeader(text: "Exercises")
                        .padding(.top, 25)
                    ForEach(self.workout.exercises, id: \.id) { exercise in
                        NavigationLink(destination: ExerciseDetailsScreen(exercise: exercise)) {
                            ExerciseViewCard(exercise: exercise)
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.top, ApplicationPadding.mainScreenVerticalPadding + 50)
                .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.darkBG)
        .zIndex(.infinity)
        .clipped()
        .ignoresSafeArea()
        .offset(y: self.menuPageTranslation.height)
        .gesture(
            DragGesture()
                .onChanged { value in
                    withAnimation {
                        if value.translation.height > .zero {
                            self.menuPageTranslation = value.translation
                        }
                    }
                }
                .onEnded { value in
                    if value.translation.height > 150 {
                        withAnimation {
                            self.isMenuOpen = false
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.menuPageTranslation = .zero
                        }
                    } else {
                        withAnimation {
                            self.menuPageTranslation = .zero
                        }
                    }
                }
        )
        .transition(.offset(y: UIScreen.main.bounds.height))
    }
    
    
    var WorkoutEngineTopNavigationBar: some View {
        VStack {
            
            
            // MARK: Exercise indecation view
            HStack {
                ForEach(0..<self.workout.exercises.count, id: \.self) { index in
                    HStack {
                        
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 5)
                    .background(self.workoutArrayIndex == index ? .darkBG : .darkBG.opacity(0.24), in: Capsule())
                }
            }
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            .frame(maxWidth: .infinity)
            
            
            HStack {
                
                
                
                // MARK: Close button
                Image(systemName: "xmark")
                    .foregroundStyle(.darkBG)
                    .frame(width: 40, height: 40)
                    .overlay {
                        Circle()
                            .stroke(.darkBG.opacity(0.28))
                    }
                    .background(.darkBG.opacity(0.18), in: Circle())
                    .onTapGesture {
                        withAnimation {
                            self.isExitDialogOpen = true
                        }
                    }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Exercise \(self.workoutArrayIndex+1)/\(self.workout.exercises.count)")
                        .foregroundStyle(.darkBG.opacity(0.5))
                        .contentTransition(.numericText(value: Double(self.workoutArrayIndex)))
                        .animation(.snappy, value: Double(self.workoutArrayIndex))
                    
                    Text(self.formatTime(self.startTiming))
                        .foregroundStyle(.darkBG.opacity(0.5))
                        .contentTransition(.numericText(value: Double(self.startTiming)))
                }
            }
            .padding(.horizontal, ApplicationPadding.mainScreenHorizontalPadding)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 15)
        }
        .frame(maxWidth: .infinity)
        .onChange(of: self.showTimerScreen) {
            if !self.showTimerScreen {
                ApplicationSounds.current.startExercise()
            }
        }
    }
}

