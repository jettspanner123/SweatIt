//
//  CoachViewController.swift
//  SweatIt
//
//  Created by Uddeshya Singh on 29/01/25.
//

import UIKit
import SwiftUI

class CoachViewController: UIViewController {
    
    var scrollView: UIScrollView = {
        let sView = UIScrollView()
        //        sView.backgroundColor = .red
        sView.showsVerticalScrollIndicator = false
        return sView
    }()
    
    var horizontalScrollView: UIScrollView = {
        let hScrollView = UIScrollView()
//        hScrollView.backgroundColor = .red
        hScrollView.showsHorizontalScrollIndicator = false
        return hScrollView
    }()
    
    var horizontalContentView: UIView = {
        let contentView = UIView()
//        contentView.backgroundColor = .yellow
        return contentView
    }()
    
    var contentView: UIView = {
        let cView = UIView()
        //        cView.backgroundColor = .yellow
        return cView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.addLinearGradient()
        self.setupScollView()
        self.setupHorizontalScrollView()
        
        let pageHeading = self.addPageHeading()
        let navigationBar = self.addNavigationBar(whichPage: "Coach")
        
        self.addPageElements()
        
        self.view.bringSubviewToFront(pageHeading)
        self.view.bringSubviewToFront(navigationBar)
    }
    
    private func addLinearGradient() {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.view.bounds
        
        gradientLayer.colors = [UIColor.darkBG.cgColor, UIColor.black.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.6)
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    private func setupScollView() {
        
        self.view.addSubview(self.scrollView)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        self.scrollView.addSubview(self.contentView)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            self.contentView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor, multiplier: 1.9),
        ])
    }
    
    
    private func setupHorizontalScrollView() {
        self.contentView.addSubview(self.horizontalScrollView)
        self.horizontalScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        self.horizontalScrollView.addSubview(self.horizontalContentView)
        self.horizontalContentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            horizontalScrollView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            horizontalScrollView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            horizontalScrollView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    
    private func addNavigationBar(whichPage: String) -> UIView {
        @State var something = 0
        let navigationBar = UIHostingController(rootView: PageNavigationBar(currentPage_t: $something, currentPage: "Coach", wantOffset: false, homeScreenAction: {
            let destinationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomePage")
            destinationViewController.modalPresentationStyle = .overFullScreen
            self.present(destinationViewController, animated: false)
        }, workoutScreenAction: {
            let destinationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ExercisePage")
            destinationViewController.modalPresentationStyle = .overFullScreen
            self.present(destinationViewController, animated: false)
        }, coachScreenAction: {
        }, dietScreenAction: {
            let destinationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DietPage")
            destinationViewController.modalPresentationStyle = .overFullScreen
            self.present(destinationViewController, animated: false)
        }, profileScreenAction: {
            let destinationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfilePage")
            destinationViewController.modalPresentationStyle = .overFullScreen
            self.present(destinationViewController, animated: false)
        }))
        navigationBar.view.frame = CGRect(origin: .zero, size: navigationBar.sizeThatFits(in: self.view.bounds.size))
        navigationBar.view.backgroundColor = .clear
        
        navigationBar.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(navigationBar.view)
        NSLayoutConstraint.activate([
            navigationBar.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 48),
            navigationBar.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            navigationBar.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            navigationBar.view.widthAnchor.constraint(equalToConstant: self.view.bounds.width),
            navigationBar.view.heightAnchor.constraint(equalToConstant: 180),
        ])
        
        return navigationBar.view
        
    }
    
    private func addPageElements() {
        let fitnessMatricHeading = UIHostingController(rootView: TertiaryHeading(titleHeading: "Fitness Metrics", secondaryHeading: "avg per week", bottomSpace: false))
        let caloriesBurnedGraph = UIHostingController(rootView: CaloriesBurnedGraph(caloriesOnWeek: [(37, 0.45, 0), (50, 0.65, 1), (39, 0.55, 2), (65, 1, 3), (48, 0.65, 4), (22, 0.35, 5), (22, 0.35, 6)]))
        let waterIntakeGraph = UIHostingController(rootView: WaterIntakeGraph(leters: 1.9))
        let workoutDoneGraph = UIHostingController(rootView: WorkoutTimingGraph(workoutTiming:  [(37, 0.45, 0), (50, 0.65, 1), (39, 0.55, 2), (65, 1, 3), (48, 0.65, 4), (22, 0.35, 5), (22, 0.35, 6)], avgWorkoutTIme: 32, workoutUnit: "Mins"))
        let caloriesIngestedGraph = UIHostingController(rootView: CaloriesIngestedGraph(proien: 75, carbs: 25, fats: 10, caloriesIngested: 2307))
        let passiveExercisesHeading = UIHostingController(rootView: TertiaryHeading(titleHeading: "Passive Activities", secondaryHeading: "other work", bottomSpace: false))
        let passiveExerciseHelperHeading = UIHostingController(rootView: TertiaryHeadingHelperHeading(text: "Avg number of steps taken around a certain hour of the day"))
        let stepPerDayGraph = UIHostingController(rootView: StepsPerDayGraph(stepsThroughoutWeek: [(0.5, 12754, 1), (0.35, 11187, 2), (0.7, 13025, 3), (0.8, 13245, 4), (0.6, 15003, 5)], avgSteps: 1325, goalSteps: 15000))
        let totalWeeklyVolumeHeading = UIHostingController(rootView: TertiaryHeading(titleHeading: "Total Weekly Volume", wantSecondaryHeading: false, secondaryHeading: "", bottomSpace: false))
        let totalWeeklyVolumeHelperHeading = UIHostingController(rootView: TertiaryHeadingHelperHeading(text: "Total working sets did for a particular muscle group"))

        let chestMuscleVolume = UIHostingController(rootView: MuscleVolumeIndicator(muscleGroup: "Arms", image: "armMuscles", sets: (4.0, 18.0)))
        let backMuscleVolume = UIHostingController(rootView: MuscleVolumeIndicator(muscleGroup: "Back", image: "backMuscles", sets:(9.0, 25.0)))
        let armsMuscleVolume = UIHostingController(rootView: MuscleVolumeIndicator(muscleGroup: "Chest", image: "chestMuscles", sets: (2.0, 10.0)))
        let shouldersMuscleVolume = UIHostingController(rootView: MuscleVolumeIndicator(muscleGroup: "Shoulders", image: "shoulderMuscles", sets: (3.0, 12.0)))

        
        
        
        
        [fitnessMatricHeading.view, passiveExercisesHeading.view, passiveExerciseHelperHeading.view, totalWeeklyVolumeHelperHeading.view ,stepPerDayGraph.view, totalWeeklyVolumeHeading.view, chestMuscleVolume.view, backMuscleVolume.view, armsMuscleVolume.view, shouldersMuscleVolume.view].forEach {
            $0.frame = CGRect(origin: .zero, size: $0.sizeThatFits(self.contentView.bounds.size))
            $0.backgroundColor = .clear
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview($0)
        }
        
        [caloriesBurnedGraph.view, waterIntakeGraph.view, workoutDoneGraph.view, caloriesIngestedGraph.view].forEach {
            $0.frame = CGRect(origin: .zero, size: $0.sizeThatFits(self.contentView.bounds.size))
            $0.backgroundColor = .clear
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.horizontalContentView.addSubview($0)
            
        }
        
        
        self.contentView.addSubview(self.horizontalScrollView)
        self.horizontalScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        self.horizontalScrollView.addSubview(self.horizontalContentView)
        self.horizontalContentView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            fitnessMatricHeading.view.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 70),
            fitnessMatricHeading.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            fitnessMatricHeading.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            passiveExercisesHeading.view.topAnchor.constraint(equalTo: self.horizontalScrollView.bottomAnchor),
            passiveExercisesHeading.view.leadingAnchor.constraint(equalTo: self.horizontalScrollView.leadingAnchor),
            passiveExercisesHeading.view.trailingAnchor.constraint(equalTo: self.horizontalScrollView.trailingAnchor),
            
            passiveExerciseHelperHeading.view.topAnchor.constraint(equalTo: passiveExercisesHeading.view.bottomAnchor),
            passiveExerciseHelperHeading.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            passiveExerciseHelperHeading.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            stepPerDayGraph.view.topAnchor.constraint(equalTo: passiveExerciseHelperHeading.view.bottomAnchor, constant: 15),
            stepPerDayGraph.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            stepPerDayGraph.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            totalWeeklyVolumeHeading.view.topAnchor.constraint(equalTo: stepPerDayGraph.view.bottomAnchor, constant: 10),
            totalWeeklyVolumeHeading.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            totalWeeklyVolumeHeading.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            totalWeeklyVolumeHelperHeading.view.topAnchor.constraint(equalTo: totalWeeklyVolumeHeading.view.bottomAnchor),
            totalWeeklyVolumeHelperHeading.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            totalWeeklyVolumeHelperHeading.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            chestMuscleVolume.view.topAnchor.constraint(equalTo: totalWeeklyVolumeHelperHeading.view.bottomAnchor, constant: 20),
            chestMuscleVolume.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            chestMuscleVolume.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),

                        
            backMuscleVolume.view.topAnchor.constraint(equalTo: chestMuscleVolume.view.bottomAnchor, constant: 20),
            backMuscleVolume.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            backMuscleVolume.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),

            
                        
            armsMuscleVolume.view.topAnchor.constraint(equalTo: backMuscleVolume.view.bottomAnchor, constant: 20),
            armsMuscleVolume.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            armsMuscleVolume.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),

            
                        
            shouldersMuscleVolume.view.topAnchor.constraint(equalTo: armsMuscleVolume.view.bottomAnchor, constant: 20),
            shouldersMuscleVolume.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            shouldersMuscleVolume.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),






            self.horizontalScrollView.topAnchor.constraint(equalTo: fitnessMatricHeading.view.bottomAnchor, constant: 20),
            self.horizontalScrollView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.horizontalScrollView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.horizontalScrollView.heightAnchor.constraint(equalToConstant: 190),
            
            self.horizontalContentView.topAnchor.constraint(equalTo: self.horizontalScrollView.topAnchor),
            self.horizontalContentView.leadingAnchor.constraint(equalTo: self.horizontalScrollView.leadingAnchor),
            self.horizontalContentView.trailingAnchor.constraint(equalTo: self.horizontalScrollView.trailingAnchor),
            self.horizontalContentView.bottomAnchor.constraint(equalTo: self.horizontalScrollView.bottomAnchor),
            self.horizontalContentView.widthAnchor.constraint(equalTo: self.horizontalScrollView.widthAnchor, multiplier: 2),
            self.horizontalContentView.heightAnchor.constraint(equalTo: self.horizontalScrollView.heightAnchor),

        ])
        
        NSLayoutConstraint.activate([
            caloriesBurnedGraph.view.topAnchor.constraint(equalTo: self.horizontalContentView.topAnchor),
            caloriesBurnedGraph.view.leadingAnchor.constraint(equalTo: self.horizontalContentView.leadingAnchor, constant: 25),
            caloriesBurnedGraph.view.bottomAnchor.constraint(equalTo: self.horizontalContentView.bottomAnchor),
            
            waterIntakeGraph.view.topAnchor.constraint(equalTo: self.horizontalContentView.topAnchor),
            waterIntakeGraph.view.leadingAnchor.constraint(equalTo: caloriesBurnedGraph.view.trailingAnchor, constant: 20),
            waterIntakeGraph.view.bottomAnchor.constraint(equalTo: self.horizontalContentView.bottomAnchor),
            
            workoutDoneGraph.view.topAnchor.constraint(equalTo: self.horizontalContentView.topAnchor),
            workoutDoneGraph.view.leadingAnchor.constraint(equalTo: waterIntakeGraph.view.trailingAnchor, constant: 20),
            workoutDoneGraph.view.bottomAnchor.constraint(equalTo: self.horizontalContentView.bottomAnchor),
            
            
            caloriesIngestedGraph.view.topAnchor.constraint(equalTo: self.horizontalContentView.topAnchor),
            caloriesIngestedGraph.view.leadingAnchor.constraint(equalTo: workoutDoneGraph.view.trailingAnchor, constant: 20),
            caloriesIngestedGraph.view.bottomAnchor.constraint(equalTo: self.horizontalContentView.bottomAnchor),
            
            
        ])
        
        
    }
    
    
    private func addPageHeading() -> UIView {
        let pageHeading = UIHostingController(rootView: PageHeader(pageHeaderTitle: "Coach", wantOffset: false))
        pageHeading.view.frame = CGRect(origin: .zero, size: pageHeading.sizeThatFits(in: self.view.bounds.size))
        pageHeading.view.backgroundColor = .clear
        
        self.view.addSubview(pageHeading.view)
        
        NSLayoutConstraint.activate([
            pageHeading.view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -64),
            pageHeading.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            pageHeading.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            pageHeading.view.heightAnchor.constraint(equalToConstant: 200),
            pageHeading.view.widthAnchor.constraint(equalToConstant: self.view.bounds.width)
            
        ])
        return pageHeading.view
    }
    
}

#Preview {
    CoachViewController()
}
